import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
                    "Help",
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

  Widget _buildExpandablePanelWidget(String question, String answer) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: _height * 0.015),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Pigment.fromString(CustomColors.grey18),
              width: _width * 0.0035,
            ),
          ),
        ),
        child: ExpandablePanel(
          controller: ExpandableController(initialExpanded: false),
          theme: ExpandableThemeData(
            iconColor: Pigment.fromString(CustomColors.grey4),
            headerAlignment: ExpandablePanelHeaderAlignment.top,
            iconPadding: EdgeInsets.zero,
            useInkWell: true,
            bodyAlignment: ExpandablePanelBodyAlignment.center,
            tapHeaderToExpand: true,
            inkWellBorderRadius: BorderRadius.circular(_width * 0.025),
            iconSize: _width * 0.055,
          ),
          header: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              question,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: _width * 0.037,
              ),
            ),
          ),
          expanded: Container(),
        ),
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
              "All Topics",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: _width * 0.052,
              ),
            ),
            SizedBox(
              height: _height * 0.035,
            ),
            _buildExpandablePanelWidget(
              "How do i find charging locations?",
              "",
            ),
            SizedBox(
              height: _height * 0.015,
            ),
            _buildExpandablePanelWidget(
              "How do i unlock my charging bay?",
              "",
            ),
            SizedBox(
              height: _height * 0.015,
            ),
            _buildExpandablePanelWidget(
              "How many scooters can i charge?",
              "",
            ),
            SizedBox(
              height: _height * 0.015,
            ),
            _buildExpandablePanelWidget(
              "What brand of scooters can i charge?",
              "",
            ),
            SizedBox(
              height: _height * 0.015,
            ),
            _buildExpandablePanelWidget(
              "How much does it cost?",
              "",
            ),
            SizedBox(
              height: _height * 0.015,
            ),
            _buildExpandablePanelWidget(
              "Can other people access my bay?",
              "",
            ),
            SizedBox(
              height: _height * 0.015,
            ),
            _buildExpandablePanelWidget(
              "What if there is an emergency?",
              "",
            ),
            SizedBox(
              height: _height * 0.08,
            ),
            Text(
              "Support Center",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: _width * 0.052,
              ),
            ),
            SizedBox(
              height: _height * 0.04,
            ),
            Text(
              "Text message",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: _width * 0.043,
              ),
            ),
            SizedBox(
              height: _height * 0.025,
            ),
            Text(
              "Call support",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
