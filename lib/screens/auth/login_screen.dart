import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/blocs/auth_bloc.dart';
import 'package:flutter_clenado/routes/routes.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/theme_utils.dart';
import 'package:flutter_clenado/utils/social_signin_type_enum.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';
import 'package:bloc_provider/bloc_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _height, _width;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> _sfKey = GlobalKey();

  AuthBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthBloc>(context);

    super.initState();
  }

  OutlineInputBorder get _inputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(_width),
        borderSide: BorderSide.none,
      );

  Widget _buildTextFieldWidget({
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required TextInputType inputType,
    @required String hint,
    bool obscureText = false,
  }) =>
      TextField(
        autofocus: false,
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        keyboardType: inputType,
        cursorWidth: _width * 0.007,
        style: GoogleFonts.inter(
          // color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: _width * 0.038,
        ),
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          isDense: false,
          contentPadding: EdgeInsets.symmetric(
            horizontal: _width * 0.06,
            vertical: 0,
          ),
          focusedBorder: _inputBorder,
          border: _inputBorder,
          enabledBorder: _inputBorder,
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: Pigment.fromString(CustomColors.grey6),
            fontWeight: FontWeight.w600,
            fontSize: _width * 0.035,
          ),
        ),
        textInputAction: TextInputAction.done,
        onEditingComplete: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
      );

  Widget get _buildSigninButtonWidget => Container(
        margin: EdgeInsets.symmetric(horizontal: _width * 0.07),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_width),
          ),
          padding: EdgeInsets.symmetric(vertical: _height * 0.02),
          height: 0,
          minWidth: double.infinity,
          color: Pigment.fromString(CustomColors.red2),
          child: Text(
            "Sign in",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: _width * 0.037,
            ),
          ),
          onPressed: () async {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            await Future.delayed(Duration(milliseconds: 150));
            // SharedPreferences preferences =
            //     await SharedPreferencesUtil.getSharedPreferences();
            // await preferences.setBool("login", true);
            Routes.drawerScreen(context);
          },
        ),
      );

  Widget _buildSocialSigninButtonWidget(SocialSigninType type) {
    Color bgColor;
    String title, iconPath = "assets/images/";

    switch (type) {
      case SocialSigninType.FB:
        bgColor = Pigment.fromString(CustomColors.blue1);
        title = "Facebook";
        iconPath += "facebook.webp";
        break;
      case SocialSigninType.GOOGLE:
        bgColor = Pigment.fromString(CustomColors.red3);
        title = "Google";
        iconPath += "google.webp";
        break;
      case SocialSigninType.APPLE:
        bgColor = Colors.black;
        title = "Apple";
        iconPath += "apple.webp";
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: _width * 0.07),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        padding: EdgeInsets.symmetric(vertical: _height * 0.01),
        height: 0,
        minWidth: double.infinity,
        color: bgColor,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: _width * 0.02),
                child: Image.asset(
                  iconPath,
                  height: _width * 0.08,
                  width: _width * 0.08,
                ),
              ),
            ),
            Text(
              "Sign in with $title",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: _width * 0.037,
              ),
            ),
          ],
        ),
        onPressed: () async {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }

          await Future.delayed(Duration(milliseconds: 150));
        },
      ),
    );
  }

  void _showSnackBar(String message) {
    _sfKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: _width * 0.038,
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Pigment.fromString(CustomColors.green1),
      ),
    );
  }

  Widget get _buildPasswordWidget => Container(
        margin: EdgeInsets.symmetric(horizontal: _width * 0.07),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_width),
          border: Border.all(
            color: Pigment.fromString(CustomColors.grey5),
            width: _width * 0.004,
          ),
        ),
        child: _buildTextFieldWidget(
          controller: _pwdController,
          focusNode: _pwdFocusNode,
          inputType: TextInputType.visiblePassword,
          hint: "Password",
          obscureText: true,
        ),
      );

  Widget get _buildEmailWidget => Container(
        margin: EdgeInsets.symmetric(horizontal: _width * 0.07),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_width),
          border: Border.all(
            color: Pigment.fromString(CustomColors.grey5),
            width: _width * 0.004,
          ),
        ),
        child: _buildTextFieldWidget(
          controller: _emailController,
          focusNode: _emailFocusNode,
          inputType: TextInputType.emailAddress,
          hint: "Email",
        ),
      );

  Widget get _buildSignupWidget => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Pigment.fromString(CustomColors.grey10),
              fontWeight: FontWeight.w600,
              fontSize: _width * 0.034,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(_width * 0.025),
            child: Padding(
              padding: EdgeInsets.all(_width * 0.015),
              child: Text(
                "Create now",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Pigment.fromString(CustomColors.red2),
                  fontWeight: FontWeight.w800,
                  fontSize: _width * 0.034,
                ),
              ),
            ),
            onTap: () async {
              await Future.delayed(Duration(milliseconds: 150));
              Routes.signupScreen(context);
            },
          ),
        ],
      );

  Widget get _buildRememberMeForgotPasswordWidget => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder<bool>(
                  initialData: false,
                  stream: _bloc.getRememberMe,
                  builder: (context, snapshot) {
                    return Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      checkColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                      value: snapshot.data,
                      onChanged: (value) {
                        _bloc.setRememberMe = value;
                      },
                    );
                  }),
              Text(
                "Remember me",
                style: GoogleFonts.inter(
                  // color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: _width * 0.033,
                ),
              ),
            ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(_width * 0.03),
            child: Padding(
              padding: EdgeInsets.all(_width * 0.02),
              child: Text(
                "Forgot Password?",
                style: GoogleFonts.inter(
                  color: Pigment.fromString(CustomColors.red2),
                  fontWeight: FontWeight.w800,
                  fontSize: _width * 0.033,
                ),
              ),
            ),
            onTap: () async {
              await Future.delayed(Duration(milliseconds: 150));
              // Routes.forgotPasswordScreen(context);
            },
          ),
        ],
      );

  Widget get _buildCircularProgressWidget => Center(
        child: CircularProgressIndicator(
          strokeWidth: _width * 0.008,
          valueColor: AlwaysStoppedAnimation<Color>(
            Pigment.fromString(CustomColors.green1),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        key: _sfKey,
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.white,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: _height * 0.09,
                ),
                Text(
                  "LOGIN",
                  style: GoogleFonts.inter(
                    // color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: _width * 0.065,
                  ),
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                _buildEmailWidget,
                SizedBox(
                  height: _height * 0.05,
                ),
                _buildPasswordWidget,
                SizedBox(
                  height: _height * 0.05,
                ),
                StreamBuilder<bool>(
                    initialData: false,
                    stream: _bloc.getLoading,
                    builder: (context, snapshot) {
                      return snapshot.data
                          ? _buildCircularProgressWidget
                          : _buildSigninButtonWidget;
                    }),
                SizedBox(
                  height: _height * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width * 0.055),
                  child: _buildRememberMeForgotPasswordWidget,
                ),
                SizedBox(
                  height: _height * 0.06,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          height: 0,
                          color: Pigment.fromString(CustomColors.grey9),
                          endIndent: 0,
                          indent: 0,
                          thickness: _height * 0.001,
                        ),
                      ),
                      SizedBox(
                        width: _width * 0.015,
                      ),
                      Text(
                        "Or sign in with",
                        style: GoogleFonts.inter(
                          color: Pigment.fromString(CustomColors.grey8),
                          fontWeight: FontWeight.w500,
                          fontSize: _width * 0.031,
                        ),
                      ),
                      SizedBox(
                        width: _width * 0.015,
                      ),
                      Expanded(
                        child: Divider(
                          height: 0,
                          color: Pigment.fromString(CustomColors.grey9),
                          endIndent: 0,
                          indent: 0,
                          thickness: _height * 0.001,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.035,
                ),
                _buildSocialSigninButtonWidget(SocialSigninType.FB),
                SizedBox(
                  height: _height * 0.023,
                ),
                _buildSocialSigninButtonWidget(SocialSigninType.GOOGLE),
                SizedBox(
                  height: _height * 0.023,
                ),
                _buildSocialSigninButtonWidget(SocialSigninType.APPLE),
                SizedBox(
                  height: _height * 0.037,
                ),
                _buildSignupWidget,
                SizedBox(
                  height: _height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();

    _pwdController.dispose();
    _pwdFocusNode.dispose();

    super.dispose();
  }
}
