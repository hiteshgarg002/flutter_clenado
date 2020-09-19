import 'package:flutter/material.dart';
import 'package:flutter_clenado/routes/routes.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CodeScreen extends StatefulWidget {
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
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
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _width * 0.04,
            ),
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
        ),
        preferredSize: AppBar().preferredSize,
      );

  Widget get _buildGoToReservationsButtonWidget => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.075,
          vertical: _height * 0.025,
        ),
        color: Pigment.fromString(CustomColors.black1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          "Go to reservations",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: _width * 0.039,
          ),
        ),
        onPressed: () async {
          await Future.delayed(Duration(milliseconds: 150));
          Routes.reservationsScreen(context);
        },
      );

  Widget get _buildUnlockCodeWidget => Container(
        width: double.infinity,
        height: _height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_width * 0.05),
          border: Border.all(
            color: Pigment.fromString(CustomColors.grey14),
            width: _width * 0.0045,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                "7",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.075,
                ),
              ),
            ),
            VerticalDivider(
              endIndent: 0,
              indent: 0,
              color: Pigment.fromString(CustomColors.grey14),
              width: 0,
              thickness: _width * 0.0045,
            ),
            Expanded(
              child: Text(
                "2",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.075,
                ),
              ),
            ),
            VerticalDivider(
              endIndent: 0,
              indent: 0,
              color: Pigment.fromString(CustomColors.grey14),
              width: 0,
              thickness: _width * 0.0045,
            ),
            Expanded(
              child: Text(
                "4",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.075,
                ),
              ),
            ),
            VerticalDivider(
              endIndent: 0,
              indent: 0,
              color: Pigment.fromString(CustomColors.grey14),
              width: 0,
              thickness: _width * 0.0045,
            ),
            Expanded(
              child: Text(
                "1",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.075,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppbarWidget,
      body: Container(
        width: _width,
        padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: _height * 0.005,
            ),
            Text(
              "Thank you!\nYour pod has been reserved.",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: _width * 0.065,
              ),
            ),
            SizedBox(
              height: _height * 0.055,
            ),
            Image.asset(
              "assets/images/success.webp",
              width: _width * 0.29,
              height: _width * 0.29,
            ),
            SizedBox(
              height: _height * 0.09,
            ),
            Text(
              "Code to unlock door #4",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: _width * 0.04,
              ),
            ),
            SizedBox(
              height: _height * 0.04,
            ),
            _buildUnlockCodeWidget,
            SizedBox(
              height: _height * 0.07,
            ),
            _buildGoToReservationsButtonWidget,
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
