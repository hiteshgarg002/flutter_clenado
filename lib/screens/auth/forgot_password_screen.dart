// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_net_bizer/blocs/auth_bloc.dart';
// import 'package:flutter_net_bizer/routes/routes.dart';
// import 'package:flutter_net_bizer/utils/custom_colors.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:pigment/pigment.dart';
// import 'package:bloc_provider/bloc_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   double _height, _width;
//   final TextEditingController _emailController = TextEditingController();

//   final FocusNode _emailFocusNode = FocusNode();

//   final GlobalKey<ScaffoldState> _sfKey = GlobalKey();

//   AuthBloc _bloc;

//   @override
//   void initState() {
//     _bloc = BlocProvider.of<AuthBloc>(context);

//     super.initState();
//   }

//   OutlineInputBorder get _inputBorder => OutlineInputBorder(
//         borderRadius: BorderRadius.circular(_width),
//         borderSide: BorderSide.none,
//       );

//   Widget _buildTextFieldWidget({
//     @required TextEditingController controller,
//     @required FocusNode focusNode,
//     @required TextInputType inputType,
//     @required String hint,
//     bool obscureText = false,
//   }) =>
//       TextField(
//         autofocus: false,
//         obscureText: obscureText,
//         controller: controller,
//         focusNode: focusNode,
//         keyboardType: inputType,
//         cursorWidth: _width * 0.007,
//         cursorColor: Colors.white,
//         style: GoogleFonts.inter(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//           fontSize: _width * 0.04,
//         ),
//         textAlign: TextAlign.center,
//         decoration: InputDecoration(
//           isDense: false,
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: _width * 0.025,
//             vertical: _height * 0.019,
//           ),
//           filled: true,
//           fillColor: Pigment.fromString(CustomColors.blue1),
//           focusedBorder: _inputBorder,
//           border: _inputBorder,
//           enabledBorder: _inputBorder,
//           hintText: hint,
//           hintStyle: GoogleFonts.inter(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//             fontSize: _width * 0.04,
//           ),
//         ),
//         textInputAction: TextInputAction.done,
//         onEditingComplete: () {
//           FocusScopeNode currentFocus = FocusScope.of(context);
//           if (!currentFocus.hasPrimaryFocus) {
//             currentFocus.unfocus();
//           }
//         },
//       );

//   Widget get _buildSubmitButtonWidget => MaterialButton(
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(_width),
//         ),
//         padding: EdgeInsets.symmetric(vertical: _height * 0.015),
//         height: 0,
//         minWidth: _width * 0.74,
//         color: Pigment.fromString(CustomColors.green1),
//         child: Text(
//           "Submit",
//           style: GoogleFonts.inter(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//             fontSize: _width * 0.046,
//           ),
//         ),
//         onPressed: () async {
//           FocusScopeNode currentFocus = FocusScope.of(context);
//           if (!currentFocus.hasPrimaryFocus) {
//             currentFocus.unfocus();
//           }

//           await Future.delayed(Duration(milliseconds: 150));

//           Navigator.pop(context);
//         },
//       );

//   void _showSnackBar(String message) {
//     _sfKey.currentState.showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//             fontSize: _width * 0.038,
//           ),
//         ),
//         duration: Duration(seconds: 2),
//         backgroundColor: Pigment.fromString(CustomColors.green1),
//       ),
//     );
//   }

//   Widget get _buildEmailWidget => Container(
//         margin: EdgeInsets.symmetric(horizontal: _width * 0.13),
//         decoration: BoxDecoration(
//           color: Pigment.fromString(CustomColors.blue1),
//           borderRadius: BorderRadius.circular(_width),
//         ),
//         child: _buildTextFieldWidget(
//           controller: _emailController,
//           focusNode: _emailFocusNode,
//           inputType: TextInputType.emailAddress,
//           hint: "Email",
//         ),
//       );

//   Widget get _buildCircularProgressWidget => Center(
//         child: CircularProgressIndicator(
//           strokeWidth: _width * 0.008,
//           valueColor: AlwaysStoppedAnimation<Color>(
//             Pigment.fromString(CustomColors.green1),
//           ),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([
//       SystemUiOverlay.top,
//       SystemUiOverlay.bottom,
//     ]);

//     _height = MediaQuery.of(context).size.height;
//     _width = MediaQuery.of(context).size.width;

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: Colors.white,
//         systemNavigationBarColor: Colors.white,
//         systemNavigationBarDividerColor: Colors.white,
//       ),
//       child: Scaffold(
//         key: _sfKey,
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: NotificationListener<OverscrollIndicatorNotification>(
//           onNotification: (overScroll) {
//             overScroll.disallowGlow();
//             return true;
//           },
//           child: SingleChildScrollView(
//             child: Container(
//               height: _height,
//               width: _width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   SizedBox(
//                     height: _height * 0.1,
//                   ),
//                   Text(
//                     "Forgot Password",
//                     style: GoogleFonts.inter(
//                       color: Pigment.fromString(CustomColors.green1),
//                       fontWeight: FontWeight.bold,
//                       fontSize: _width * 0.06,
//                     ),
//                   ),
//                   SizedBox(
//                     height: _height * 0.09,
//                   ),
//                   SizedBox(
//                     width: _width * 0.7,
//                     child: Text(
//                       "Enter your email to get the password",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.inter(
//                         color: Pigment.fromString(CustomColors.grey2),
//                         fontWeight: FontWeight.w600,
//                         fontSize: _width * 0.03,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: _height * 0.04,
//                   ),
//                   _buildEmailWidget,
//                   SizedBox(
//                     height: _height * 0.012,
//                   ),
//                   StreamBuilder<bool>(
//                       initialData: false,
//                       stream: _bloc.getLoading,
//                       builder: (context, snapshot) {
//                         return snapshot.data
//                             ? _buildCircularProgressWidget
//                             : _buildSubmitButtonWidget;
//                       }),
//                   SizedBox(
//                     height: _height * 0.02,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _emailFocusNode.dispose();

//     super.dispose();
//   }
// }
