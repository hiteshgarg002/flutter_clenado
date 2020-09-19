import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clenado/blocs/settings_bloc.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/custom_toggle_buton_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _height, _width;

  SettingsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SettingsBloc>(context);
  }

  Widget get _buildAppbarWidget => PreferredSize(
        child: Container(
          height: AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Colors.white,
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
                          color: Colors.black,
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
                      color: Colors.black,
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
                       color: Pigment.fromString(CustomColors.black2),
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
                            ? Colors.black
                            : Pigment.fromString(CustomColors.grey20),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: snapshot.data == index
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
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
                      color: Pigment.fromString(CustomColors.black2),
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
                            ? Colors.black
                            : Pigment.fromString(CustomColors.grey20),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: snapshot.data == enabled
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
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

  Widget get _buildDarkModeWidget => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Dark mode",
            style: GoogleFonts.inter(
              color: Pigment.fromString(CustomColors.black2),
              fontWeight: FontWeight.w900,
              fontSize: _width * 0.058,
            ),
          ),
          FlutterSwitch(
            value: true,
            width: _width * 0.155,
            height: _height * 0.048,
            toggleSize: _width * 0.07,
            borderRadius: _width,
            padding: _width * 0.01,
            showOnOff: false,
            activeColor: Colors.black,
            inactiveColor: Pigment.fromString(CustomColors.grey21),
            toggleColor: Pigment.fromString(CustomColors.grey20),
            onToggle: (val) {},
          ),
          // CustomToggleButtonWidget(
          //   value: false,
          //   width: _width,
          //   textOff: "",
          //   textOn: "",
          //   colorOff: Pigment.fromString(CustomColors.grey21),
          //   colorOn: Pigment.fromString(CustomColors.grey21),
          //   onChanged: (v) {},
          //   onSwipe: () {},
          //   onTap: () {},
          // ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
                color: Pigment.fromString(CustomColors.black2),
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
                color: Pigment.fromString(CustomColors.black2),
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
                color: Pigment.fromString(CustomColors.black2),
                fontWeight: FontWeight.w900,
                fontSize: _width * 0.043,
              ),
            ),SizedBox(
              height: _height * 0.033,
            ),
            Text(
              "Privacy Policy",
              style: GoogleFonts.inter(
                color: Pigment.fromString(CustomColors.black2),
                fontWeight: FontWeight.w900,
                fontSize: _width * 0.043,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
