import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clenado/blocs/auth_bloc.dart';
import 'package:flutter_clenado/screens/auth/login_screen.dart';
import 'package:flutter_clenado/screens/auth/signup_screen.dart';
import 'package:flutter_clenado/screens/drawer/account_screen.dart';
import 'package:flutter_clenado/screens/drawer/drawer_screen.dart';
import 'package:flutter_clenado/screens/drawer/reservations_screen.dart';
import 'animated_page_route.dart';

class Routes {
  static void drawerScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return DrawerScreen();
      }),
      (route) => false,
    );
  }

  static void loginScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          creator: (c, b) => AuthBloc(),
          child: LoginScreen(),
        );
      }),
      (route) => false,
    );
  }

  static void signupScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          creator: (c, b) => AuthBloc(),
          child: SignupScreen(),
        );
      }),
    );
  }

  // static void signupScreen(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     CupertinoPageRoute(builder: (BuildContext context) {
  //       return BlocProvider(
  //         creator: (c, b) => AuthBloc(),
  //         child: SignupScreen(),
  //       );
  //     }),
  //   );
  // }

  // static void forgotPasswordScreen(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     CupertinoPageRoute(builder: (BuildContext context) {
  //       return BlocProvider(
  //         creator: (c, b) => AuthBloc(),
  //         child: ForgotPasswordScreen(),
  //       );
  //     }),
  //   );
  // }

  // static void verifyOtpScreen(BuildContext context, String email) {
  //   Navigator.push(
  //     context,
  //     CupertinoPageRoute(builder: (BuildContext context) {
  //       return BlocProvider(
  //         creator: (c, b) => AuthBloc(),
  //         child: VerifyOTPScreen(email),
  //       );
  //     }),
  //   );
  // }

  static void accountScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return AccountScreen();
      }),
    );
  }

  static void reservationsScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return ReservationsScreen();
      }),
    );
  }
}
