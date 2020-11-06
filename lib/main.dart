import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/blocs/auth_bloc.dart';
import 'package:flutter_clenado/screens/auth/login_screen.dart';
import 'package:flutter_clenado/utils/shared_preferences_util.dart';
import 'package:flutter_clenado/utils/theme_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/settings_bloc.dart';

SharedPreferences _preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GestureBinding.instance.resamplingEnabled = true;

  // setting app orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // hiding status bar & nav bar
  // SystemChrome.setEnabledSystemUIOverlays([]);

  _preferences = await SharedPreferencesUtil.getSharedPreferences();

  runApp(
    BlocProvider(
      creator: (c, b) => SettingsBloc(),
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  SettingsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SettingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = _preferences.getBool("darkMode") != null &&
        _preferences.getBool("darkMode");

    return StreamBuilder<bool>(
      initialData: isDarkMode,
      stream: _bloc.getDarkMode,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Clenado",
          theme: ThemeUtils.lightTheme,
          darkTheme: ThemeUtils.darkTheme,
          themeMode: snapshot.data ? ThemeMode.dark : ThemeMode.light,
          home: BlocProvider(
            creator: (c, b) => AuthBloc(),
            child: LoginScreen(),
          ),
        );
      },
    );
  }
}
