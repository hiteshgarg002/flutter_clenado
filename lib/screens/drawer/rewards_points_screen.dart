import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/theme_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RewardsPointsScreen extends StatefulWidget {
  @override
  _RewardsPointsScreenState createState() => _RewardsPointsScreenState();
}

class _RewardsPointsScreenState extends State<RewardsPointsScreen> {
  double _height, _width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    "Rewards & Points",
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

  Widget _buildRecentListItemWidget() => Container(
        margin: EdgeInsets.only(bottom: _height * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/charge_circular.webp",
                    width: _width * 0.13,
                    height: _width * 0.13,
                  ),
                  SizedBox(
                    width: _width * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "1667 K Street NW",
                        style: GoogleFonts.inter(
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: _width * 0.038,
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.005,
                      ),
                      Text(
                        "08/12/2020 19:32",
                        style: GoogleFonts.inter(
                          color: Pigment.fromString(CustomColors.grey17),
                          fontWeight: FontWeight.w600,
                          fontSize: _width * 0.033,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "20",
              style: GoogleFonts.inter(
                // color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: _width * 0.07,
              ),
            ),
          ],
        ),
      );

  Widget get _buildCircularProgressWidget => CircularPercentIndicator(
        radius: _width * 0.47,
        lineWidth: _width * 0.065,
        percent: 0.65,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "650",
              style: GoogleFonts.inter(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: _width * 0.09,
              ),
            ),
            Text(
              "of 1000 points",
              style: GoogleFonts.inter(
                // color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: _width * 0.028,
              ),
            ),
          ],
        ),
        backgroundColor: Pigment.fromString(CustomColors.grey13),
        progressColor: Pigment.fromString(CustomColors.red4),
        animateFromLastPercent: true,
        animation: true,
        circularStrokeCap: CircularStrokeCap.round,
        animationDuration: 700,
        backgroundWidth: _width * 0.065,
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
        body: Container(
          width: _width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: _height * 0.03,
              ),
              _buildCircularProgressWidget,
              SizedBox(
                height: _height * 0.07,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: _width * 0.055,
                  right: _width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Recents",
                      style: GoogleFonts.inter(
                        // color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: _width * 0.06,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(_width * 0.02),
                      child: Padding(
                        padding: EdgeInsets.all(_width * 0.015),
                        child: Text(
                          "See all",
                          style: GoogleFonts.inter(
                            color: Pigment.fromString(CustomColors.grey10),
                            fontWeight: FontWeight.bold,
                            fontSize: _width * 0.037,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.035,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: _width * 0.055),
                  child: Text(
                    "August 2020",
                    style: GoogleFonts.inter(
                      color: Pigment.fromString(CustomColors.grey17),
                      fontWeight: FontWeight.w500,
                      fontSize: _width * 0.034,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.012,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.055),
                child: Divider(
                  height: 0,
                ),
              ),
              SizedBox(
                height: _height * 0.012,
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();

                    return true;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: _width * 0.055,
                      vertical: _height * 0.013,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildRecentListItemWidget();
                    },
                  ),
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
