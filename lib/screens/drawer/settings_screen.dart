import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/blocs/settings_bloc.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/shared_preferences_util.dart';
import 'package:flutter_clenado/utils/theme_utils.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _height, _width;

  SharedPreferences _preferences;

  SettingsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SettingsBloc>(context);
    _getSharedPreferences();
  }

  Future<void> _getSharedPreferences() async {
    _preferences = await SharedPreferencesUtil.getSharedPreferences();

    // await Future.delayed(Duration(seconds: 1));
    _bloc.setLoading = false;
  }

  Widget get _buildAppbarWidget => PreferredSize(
        child: Container(
          height: AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          // color: Colors.white,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _width * 0.04,
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(_width * 0.02),
                      child: Padding(
                        padding: EdgeInsets.all(_width * 0.015),
                        child: Icon(
                          Icons.arrow_back,
                          // color: Colors.black,
                          size: _width * 0.08,
                        ),
                      ),
                      onTap: () async {
                        await Future.delayed(Duration(milliseconds: 150));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Settings",
                    style: GoogleFonts.inter(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: _width * 0.047,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: AppBar().preferredSize,
      );

  Widget _buildNavigationTypeWidget(int index, String title) => InkWell(
        borderRadius: BorderRadius.circular(_width * 0.02),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Pigment.fromString(CustomColors.black2),
                  fontWeight: FontWeight.w600,
                  fontSize: _width * 0.04,
                ),
              ),
              StreamBuilder<int>(
                  initialData: 0,
                  stream: _bloc.getNavigationType,
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.only(right: _width * 0.035),
                      height: _width * 0.07,
                      width: _width * 0.07,
                      decoration: BoxDecoration(
                        color: snapshot.data == index
                            ? Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black
                            : Pigment.fromString(CustomColors.grey20),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: snapshot.data == index
                          ? Icon(
                              Icons.done,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white,
                              size: _width * 0.045,
                            )
                          : Container(),
                    );
                  }),
            ],
          ),
        ),
        onTap: () {
          _bloc.setNavigationType = index;
        },
      );

  Widget _buildEnableNotificationWidget(bool enabled, String title) => InkWell(
        borderRadius: BorderRadius.circular(_width * 0.02),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Pigment.fromString(CustomColors.black2),
                  fontWeight: FontWeight.w600,
                  fontSize: _width * 0.04,
                ),
              ),
              StreamBuilder<bool>(
                  initialData: true,
                  stream: _bloc.getEnableNotifications,
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.only(right: _width * 0.035),
                      height: _width * 0.07,
                      width: _width * 0.07,
                      decoration: BoxDecoration(
                        color: snapshot.data == enabled
                            ? Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black
                            : Pigment.fromString(CustomColors.grey20),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: snapshot.data == enabled
                          ? Icon(
                              Icons.done,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white,
                              size: _width * 0.045,
                            )
                          : Container(),
                    );
                  }),
            ],
          ),
        ),
        onTap: () {
          _bloc.setEnableNotifications = enabled;
        },
      );

  Widget get _buildToggleWidget => StreamBuilder<bool>(
        initialData: _preferences.getBool("darkMode") != null &&
            _preferences.getBool("darkMode"),
        stream: _bloc.getDarkMode,
        builder: (context, snapshot) {
          return FlutterSwitch(
            value: snapshot.data,
            width: _width * 0.155,
            height: _height * 0.048,
            toggleSize: _width * 0.07,
            borderRadius: _width,
            padding: _width * 0.01,
            showOnOff: false,
            activeColor: Colors.black,
            inactiveColor: Pigment.fromString(CustomColors.grey21),
            toggleColor: Pigment.fromString(CustomColors.grey20),
            onToggle: (value) {
              _preferences.setBool("darkMode", value);
              _bloc.setDarkMode = value;
            },
          );
        },
      );

  Widget get _buildDarkModeWidget => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Dark mode",
            style: GoogleFonts.inter(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Pigment.fromString(CustomColors.black2),
              fontWeight: FontWeight.w900,
              fontSize: _width * 0.058,
            ),
          ),
          StreamBuilder<bool>(
            initialData: true,
            stream: _bloc.getLoading,
            builder: (context, snapshot) {
              return snapshot.data
                  ? _buildCircularProgressWidget
                  : _buildToggleWidget;
            },
          ),
        ],
      );

  Widget get _buildCircularProgressWidget => Center(
        child: CircularProgressIndicator(
          strokeWidth: _width * 0.008,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: _buildAppbarWidget,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: _width * 0.075,
            vertical: _height * 0.02,
          ),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Navigation",
                style: GoogleFonts.inter(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Pigment.fromString(CustomColors.black2),
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.058,
                ),
              ),
              Divider(
                color: Pigment.fromString(CustomColors.grey18),
                thickness: _width * 0.0035,
                height: _height * 0.018,
              ),
              SizedBox(
                height: _height * 0.013,
              ),
              _buildNavigationTypeWidget(0, "Apple maps"),
              SizedBox(
                height: _height * 0.033,
              ),
              _buildNavigationTypeWidget(1, "Google maps"),
              SizedBox(
                height: _height * 0.033,
              ),
              _buildNavigationTypeWidget(2, "Waze"),
              SizedBox(
                height: _height * 0.06,
              ),
              Text(
                "Notifications",
                style: GoogleFonts.inter(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Pigment.fromString(CustomColors.black2),
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.058,
                ),
              ),
              Divider(
                color: Pigment.fromString(CustomColors.grey18),
                thickness: _width * 0.0035,
                height: _height * 0.018,
              ),
              SizedBox(
                height: _height * 0.013,
              ),
              _buildEnableNotificationWidget(true, "Push notifications"),
              SizedBox(
                height: _height * 0.033,
              ),
              _buildEnableNotificationWidget(false, "Don't notify me"),
              SizedBox(
                height: _height * 0.09,
              ),
              _buildDarkModeWidget,
              SizedBox(
                height: _height * 0.11,
              ),
              Text(
                "Terms of Service",
                style: GoogleFonts.inter(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Pigment.fromString(CustomColors.black2),
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.043,
                ),
              ),
              SizedBox(
                height: _height * 0.033,
              ),
              Text(
                "Privacy Policy",
                style: GoogleFonts.inter(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Pigment.fromString(CustomColors.black2),
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.043,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
