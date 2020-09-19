import 'package:flutter/material.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InviteScreen extends StatefulWidget {
  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
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
                    Icons.close,
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
        ),
        preferredSize: AppBar().preferredSize,
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
        padding: EdgeInsets.symmetric(horizontal: _width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: _height * 0.005,
            ),
            Text(
              "Invite Friends & earn up to \$20",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: _width * 0.052,
              ),
            ),
            SizedBox(
              height: _height * 0.07,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    "assets/images/invite_artwork_one.webp",
                    height: _height * 0.3,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    "assets/images/invite_artwork_two.webp",
                    height: _height * 0.24,
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: _height * 0.05,
            ),
            Text(
              "Earn up to \$20 for each friend you refer and reserves at least 10 pods in the first month",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: _width * 0.039,
              ),
            ),
            SizedBox(
              height: _height * 0.15,
            ),
            RichText(
              text: TextSpan(
                text: "REFERRAL CODE: ",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: _width * 0.038,
                ),
                children: [
                  TextSpan(
                    text: "KTH738299",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: _width * 0.038,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _height * 0.04,
            ),
            MaterialButton(
              height: 0,
              minWidth: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: _height * 0.025,
              ),
              color: Pigment.fromString(CustomColors.black1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_width),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Text(
                "Share Code",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: _width * 0.042,
                ),
              ),
              onPressed: () async {
                await Future.delayed(Duration(milliseconds: 150));
              },
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
