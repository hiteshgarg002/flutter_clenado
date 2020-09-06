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

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppbarWidget,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
