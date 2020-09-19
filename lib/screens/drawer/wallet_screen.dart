import 'package:flutter/material.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
                    "Wallet",
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

  Widget get _buildAddPaymentMethodButtonWidget => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.038,
          vertical: _height * 0.02,
        ),
        color: Pigment.fromString(CustomColors.black1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          "Add Payment Method",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: _width * 0.037,
          ),
        ),
        onPressed: () {},
      );

  Widget get _buildAddFundsButtonWidget => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.06,
          vertical: _height * 0.016,
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.black,
              size: _width * 0.052,
            ),
            Text(
              "Add Funds",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: _width * 0.034,
              ),
            ),
          ],
        ),
        onPressed: () {},
      );

  Widget get _buildBalanceCardWidget => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Pigment.fromString(CustomColors.black1),
          borderRadius: BorderRadius.circular(_width * 0.03),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.055,
          vertical: _height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Balance",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: _width * 0.043,
              ),
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Text(
              "Today Aug 27, 2020",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: _width * 0.03,
              ),
            ),
            SizedBox(
              height: _height * 0.027,
            ),
            Text(
              "\$150.00",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: _width * 0.13,
              ),
            ),
            SizedBox(
              height: _height * 0.033,
            ),
            _buildAddFundsButtonWidget,
          ],
        ),
      );

  Widget _buildPaymentMethodWidget(String iconPath, String last4) => InkWell(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: _width * 0.025,
            vertical: _height * 0.005,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: _height * 0.001,
                color: Pigment.fromString(CustomColors.grey9),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                iconPath,
                width: _width * 0.13,
                height: _width * 0.13,
                fit: BoxFit.cover,alignment: Alignment.centerLeft,
              ),
              SizedBox(
                width: _width * 0.02,
              ),
              Expanded(
                child: Text(
                  "...$last4",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: _width * 0.037,
                  ),
                ),
              ),
              SizedBox(
                width: _width * 0.02,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: _width * 0.06,
                color: Pigment.fromString(CustomColors.grey4),
              ),
            ],
          ),
        ),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppbarWidget,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();

          return true;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: _width * 0.035,
            vertical: _height * 0.01,
          ),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildBalanceCardWidget,
              SizedBox(
                height: _height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.only(left: _width * 0.025),
                child: Text(
                  "Payment Method",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: _width * 0.04,
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.04,
              ),
              _buildPaymentMethodWidget("assets/images/visa.webp", "1234"),
              _buildPaymentMethodWidget(
                  "assets/images/master_card.webp", "1234"),
              _buildPaymentMethodWidget("assets/images/amex.webp", "1234"),
              SizedBox(
                height: _height * 0.025,
              ),
              Padding(
                padding: EdgeInsets.only(left: _width * 0.02),
                child: _buildAddPaymentMethodButtonWidget,
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
