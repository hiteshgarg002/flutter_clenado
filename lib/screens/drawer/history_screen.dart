import 'package:flutter/material.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                          size: _width * 0.07,
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
                    "History",
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
                        vertical: _height * 0.002,
                      ),
                      decoration: BoxDecoration(
                   color: Pigment.fromString(CustomColors.red1),
                        borderRadius: BorderRadius.circular(_width),
                      ),
                      child: Text(
                        "Inactive",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: _width * 0.033,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: _height * 0.027,
                ),
                Text(
                  "1667 K Street NW, Washington DC 20006",
                  style: GoogleFonts.inter(
                    color: Colors.black,
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
                    MaterialButton(
                      height: 0,
                      minWidth: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: _width * 0.05,
                        vertical: _height * 0.01,
                      ),
                      color: Pigment.fromString(CustomColors.grey12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_width),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text(
                        "navigate",
                        style: GoogleFonts.inter(
                          color: Pigment.fromString(CustomColors.grey11),
                          fontWeight: FontWeight.w600,
                          fontSize: _width * 0.04,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: _width * 0.07,
                      color: Pigment.fromString(CustomColors.grey4),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {},
        ),
      );

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
