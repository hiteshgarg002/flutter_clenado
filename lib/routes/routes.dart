import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clenado/blocs/auth_bloc.dart';
import 'package:flutter_clenado/blocs/drawer_bloc.dart';
import 'package:flutter_clenado/blocs/promotions_bloc.dart';
import 'package:flutter_clenado/blocs/reservations_bloc.dart';
import 'package:flutter_clenado/blocs/history_bloc.dart';
import 'package:flutter_clenado/blocs/rewards_points_bloc.dart';
import 'package:flutter_clenado/blocs/wallet_bloc.dart';
import 'package:flutter_clenado/screens/auth/login_screen.dart';
import 'package:flutter_clenado/screens/auth/signup_screen.dart';
import 'package:flutter_clenado/screens/code_screen.dart';
import 'package:flutter_clenado/screens/drawer/account_screen.dart';
import 'package:flutter_clenado/screens/drawer/drawer_screen.dart';
import 'package:flutter_clenado/screens/drawer/promotions/promotions_tabs_screen.dart';
import 'package:flutter_clenado/screens/drawer/reservations_screen.dart';
import 'package:flutter_clenado/screens/drawer/history_screen.dart';
import 'package:flutter_clenado/screens/drawer/rewards_points_screen.dart';
import 'package:flutter_clenado/screens/drawer/wallet_screen.dart';
import 'package:flutter_clenado/screens/invite_screen.dart';
import 'package:flutter_clenado/screens/drawer/help_screen.dart';
import 'animated_page_route.dart';

class Routes {
  static void drawerScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          creator: (c, b) => DrawerBloc(),
          child: DrawerScreen(),
        );
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
        return BlocProvider(
          creator: (c, b) => ReservationsBloc(),
          child: ReservationsScreen(),
        );
      }),
    );
  }

  static void historyScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          creator: (c, b) => HistoryBloc(),
          child: HistoryScreen(),
        );
      }),
    );
  }

  static void rewardsPointsScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          creator: (c, b) => RewardsPointsBloc(),
          child: RewardsPointsScreen(),
        );
      }),
    );
  }

  static void walletScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          creator: (c, b) => WalletBloc(),
          child: WalletScreen(),
        );
      }),
    );
  }

  static void promotionsTabsScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          creator: (c, b) => PromotionsBloc(),
          child: PromotionsTabsScreen(),
        );
      }),
    );
  }

  static void helpScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return HelpScreen();
      }),
    );
  }

  static void inviteScreen(BuildContext context) {
    Navigator.push(
      context,
      AnimatedPageRoute.sharedAxisPageRoute(
        () => InviteScreen(),
      ),
    );
  }

  static void codeScreen(BuildContext context) {
    Navigator.push(
      context,
      AnimatedPageRoute.sharedAxisPageRoute(
        () => CodeScreen(),
      ),
    );
  }
}
