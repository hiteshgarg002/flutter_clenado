// import 'package:bloc_provider/bloc_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_net_bizer/blocs/auth_bloc.dart';
// import 'package:flutter_net_bizer/routes/routes.dart';
// import 'package:flutter_net_bizer/utils/custom_colors.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:pigment/pigment.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class VerifyOTPScreen extends StatefulWidget {
//   final String email;

//   VerifyOTPScreen(this.email);

//   @override
//   _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
// }

// class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
//   final GlobalKey<ScaffoldState> _sfKey = GlobalKey();
//   final TextEditingController _otpController = TextEditingController();
//   final FocusNode _otpFocusNode = FocusNode();
//   SharedPreferences _preferences;
//   double _height, _width;

//   AuthBloc _bloc;

//   @override
//   void initState() {
//     _bloc = BlocProvider.of<AuthBloc>(context);

//     super.initState();
//   }

//   Future<void> _verifyOTP() async {
//     FocusScopeNode currentFocus = FocusScope.of(context);
//     if (!currentFocus.hasPrimaryFocus) {
//       currentFocus.unfocus();
//     }

//     await Future.delayed(Duration(milliseconds: 150));

//     // if (_otpController.text.isEmpty) {
//     //   _showSnackBar("OTP is required!");

//     //   return;
//     // }

//     // if (_otpController.text.length < 6) {
//     //   _showSnackBar("Invalid OTP!");

//     //   return;
//     // }

//     // await Future.delayed(Duration(milliseconds: 200));
//     // _bloc.setLoadingStatus = true;

//     // Map res = await NetworkCalls.verifyOTP(widget.mobile, _otpController.text);

//     // if (res["data"] != null && res["status"] != "201") {
//     //   if (_preferences == null) {
//     //     _preferences = await SharedPreferencesUtil.getSharedPreferences();
//     //   }

//     //   Map dataMap = res["data"] as Map;

//     //   for (MapEntry entry in dataMap.entries) {
//     //     if (entry.value is String) {
//     //       await _preferences.setString(entry.key, entry.value);
//     //     }
//     //   }

//     //   await _preferences.setBool("login", true);

//     //   Routes.bottomNavbarScreen(context);

//     //   _bloc.setLoadingStatus = false;
//     //   return;
//     // }

//     // _bloc.setLoadingStatus = false;

//     // // invalid OTP
//     // _showSnackBar("Invalid OTP!");

//     Routes.loginScreen(context);
//   }

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
//         onPressed: _verifyOTP,
//       );

//   Widget get _buildOTPWidget => PinCodeTextField(
//         length: 6,
//         obsecureText: false,
//         animationType: AnimationType.scale,
//         pinTheme: PinTheme(
//           shape: PinCodeFieldShape.box,
//           borderRadius: BorderRadius.circular(_width * 0.02),
//           fieldHeight: _height * 0.06,
//           fieldWidth: _width * 0.1,
//           activeColor: Pigment.fromString(CustomColors.blue1),
//           selectedColor: Pigment.fromString(CustomColors.blue1),
//           disabledColor: Pigment.fromString(CustomColors.blue1),
//           inactiveColor: Pigment.fromString(CustomColors.blue1),
//           activeFillColor: Pigment.fromString(CustomColors.blue1),
//           inactiveFillColor: Pigment.fromString(CustomColors.blue1),
//           selectedFillColor: Pigment.fromString(CustomColors.blue1),
//           borderWidth: _width * 0.003,
//         ),
//         animationDuration: Duration(milliseconds: 200),
//         autoDisposeControllers: true,
//         textInputType: TextInputType.number,
//         autoDismissKeyboard: true,
//         backgroundColor: Colors.white,
//         textInputAction: TextInputAction.done,
//         controller: _otpController,
//         focusNode: _otpFocusNode,
//         enableActiveFill: true,
//         textStyle: GoogleFonts.inter(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//           fontSize: _width * 0.04,
//         ),
//         onChanged: (value) {},
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
//                     "Get OTP",
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
//                       "Your OTP has been send on your registerd Email",
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
//                   Container(
//                     width: _width * 0.63,
//                     child: _buildOTPWidget,
//                   ),
//                   SizedBox(
//                     height: _height * 0.01,
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
//     super.dispose();
//   }
// }
