import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/theme_utils.dart';
import 'package:flutter_clenado/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pigment/pigment.dart';

class ReservationsScreen extends StatefulWidget {
  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
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
                    "Reservations",
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

  Widget _buildBottomSheetInfoRowWidget(String title, String value) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: _width * 0.034,
              ),
            ),
          ),
          SizedBox(
            width: _width * 0.04,
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: _width * 0.034,
            ),
          ),
        ],
      );

  Widget get _buildCancelReservationButtonWidget => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.052,
          vertical: _height * 0.0225,
        ),
        color: Theme.of(context).brightness == Brightness.light
            ? Pigment.fromString(CustomColors.black1)
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          "Cancel Reservation",
          style: GoogleFonts.inter(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: _width * 0.038,
          ),
        ),
        onPressed: () {},
      );

  Future<void> _showReservationDetailsSheet() async {
    return await showMaterialModalBottomSheet(
      context: context,
      // backgroundColor: Colors.white,
      enableDrag: true,
      isDismissible: false,
      bounce: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: _width * 0.02),
                          child: MaterialButton(
                            height: 0,
                            minWidth: 0,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(_width * 0.015),
                            child: Icon(
                              Icons.close,
                              size: _width * 0.075,
                            ),
                            onPressed: () async {
                              await Future.delayed(Duration(milliseconds: 150));
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: _width * 0.032,
                          vertical: _height * 0.0035,
                        ),
                        decoration: BoxDecoration(
                          color: Pigment.fromString(CustomColors.green1),
                          borderRadius: BorderRadius.circular(_width),
                        ),
                        child: Text(
                          "Active",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: _width * 0.034,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
                    child: Text(
                      "Washignton DC",
                      style: GoogleFonts.inter(
                        // color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: _width * 0.055,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.023,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: _width * 0.08),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "1667 K Street NW, Washington DC 20006",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            // color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: _width * 0.034,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.025,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "2.5 miles away",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                // color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: _width * 0.032,
                              ),
                            ),
                            SizedBox(
                              width: _width * 0.05,
                            ),
                            _buildNavigateButtonWidget(),
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.07,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Pigment.fromString(CustomColors.grey12),
                            borderRadius: BorderRadius.circular(_width * 0.035),
                          ),
                          padding: EdgeInsets.all(_width * 0.055),
                          child: Column(
                            children: <Widget>[
                              _buildBottomSheetInfoRowWidget(
                                "Price:",
                                "\$2.50/hr",
                              ),
                              SizedBox(
                                height: _height * 0.025,
                              ),
                              _buildBottomSheetInfoRowWidget(
                                "Charging ports per bay:",
                                "20",
                              ),
                              SizedBox(
                                height: _height * 0.025,
                              ),
                              _buildBottomSheetInfoRowWidget(
                                "Reservation starts:",
                                "08/23 - 5:30pm",
                              ),
                              SizedBox(
                                height: _height * 0.025,
                              ),
                              _buildBottomSheetInfoRowWidget(
                                "Reservation ends:",
                                "08/29 - 6:00pm",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.1,
                        ),
                        _buildCancelReservationButtonWidget,
                        SizedBox(
                          height: _height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNavigateButtonWidget() => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.058,
          vertical: _height * 0.014,
        ),
        color: Pigment.fromString(CustomColors.red1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          "navigate",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: _width * 0.04,
          ),
        ),
        onPressed: () {},
      );

  Widget _buildListViewItemWidget() => Card(
        elevation: 5,
        margin: EdgeInsets.only(
          bottom: _height * 0.025,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width * 0.04),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(_width * 0.03),
          child: Container(
            padding: EdgeInsets.all(_width * 0.04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_width * 0.03),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "August 23 - 29",
                      style: GoogleFonts.inter(
                        color: Pigment.fromString(CustomColors.grey3),
                        fontWeight: FontWeight.w600,
                        fontSize: _width * 0.037,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: _width * 0.032,
                        vertical: _height * 0.0035,
                      ),
                      decoration: BoxDecoration(
                        color: Pigment.fromString(CustomColors.green1),
                        borderRadius: BorderRadius.circular(_width),
                      ),
                      child: Text(
                        "Active",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: _width * 0.034,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.027,
                ),
                Text(
                  "1667 K Street NW, Washington DC 20006",
                  style: GoogleFonts.inter(
                    // color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: _width * 0.036,
                  ),
                ),
                SizedBox(
                  height: _height * 0.04,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildNavigateButtonWidget(),
                    Image.asset(
                      "assets/images/right_arrow.webp",
                      width: _width * 0.07,
                      height: _width * 0.07,
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 150));
            await _showReservationDetailsSheet();
          },
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
        body: Column(
          children: <Widget>[
            SizedBox(
              height: _height * 0.03,
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: _width * 0.05, vertical: _height * 0.01),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildListViewItemWidget();
                  },
                ),
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
