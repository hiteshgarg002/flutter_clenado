import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clenado/blocs/auth_bloc.dart';
import 'package:flutter_clenado/blocs/drawer_bloc.dart';
import 'package:flutter_clenado/blocs/promotions_bloc.dart';
import 'package:flutter_clenado/blocs/reservations_bloc.dart';
import 'package:flutter_clenado/blocs/history_bloc.dart';
import 'package:flutter_clenado/blocs/rewards_points_bloc.dart';
import 'package:flutter_clenado/blocs/wallet_bloc.dart';
import 'package:flutter_clenado/blocs/settings_bloc.dart';
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
import 'package:flutter_clenado/screens/drawer/settings_screen.dart';
import 'package:flutter_clenado/screens/invite_screen.dart';
import 'package:flutter_clenado/screens/drawer/help_screen.dart';
import 'animated_page_route.dart';

class Routes {
  static Future<Widget> _buildScreenAsync(Widget screen) async {
    return Future.microtask(() {
      return screen;
    });
  }

  static Future<void> drawerScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => DrawerBloc(),
        child: DrawerScreen(),
      ),
    );

    return Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
      (route) => false,
    );
  }

  static Future<void> loginScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => AuthBloc(),
        child: LoginScreen(),
      ),
    );

    return Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
      (route) => false,
    );
  }

  static Future<void> signupScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => AuthBloc(),
        child: SignupScreen(),
      ),
    );

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> accountScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      AccountScreen(),
    );

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> reservationsScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => ReservationsBloc(),
        child: ReservationsScreen(),
      ),
    );

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> historyScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => HistoryBloc(),
        child: HistoryScreen(),
      ),
    );

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> rewardsPointsScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => RewardsPointsBloc(),
        child: RewardsPointsScreen(),
      ),
    );

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> walletScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => WalletBloc(),
        child: WalletScreen(),
      ),
    );

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> promotionsTabsScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => PromotionsBloc(),
        child: PromotionsTabsScreen(),
      ),
    );

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> helpScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(HelpScreen());

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> settingsScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      BlocProvider(
        creator: (c, b) => SettingsBloc(),
        child: SettingsScreen(),
      ),
    );

    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) {
        return screen;
      }),
    );
  }

  static Future<void> inviteScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      InviteScreen(),
    );

    return Navigator.push(
      context,
      AnimatedPageRoute.sharedAxisPageRoute(
        () => screen,
      ),
    );
  }

  static Future<void> codeScreen(BuildContext context) async {
    Widget screen = await _buildScreenAsync(
      CodeScreen(),
    );

    return Navigator.push(
      context,
      AnimatedPageRoute.sharedAxisPageRoute(
        () => screen,
      ),
    );
  }
}
