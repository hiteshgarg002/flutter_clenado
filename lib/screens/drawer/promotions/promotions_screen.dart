import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_clenado/blocs/promotions_bloc.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/promotions_enum.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';

class PromotionsScreen extends StatefulWidget {
  final Promotions promotionType;

  PromotionsScreen(this.promotionType);
  @override
  _PromotionsScreenState createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  double _height, _width;
  PromotionsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<PromotionsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();

          return true;
        },
        child: Container(
          margin: EdgeInsets.only(top: _height * 0.03),
          child: widget.promotionType == Promotions.CURRENT
              ? Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.035),
                child: Text(
                    "There are no promotions available for you right now. We'll notify you when one comes up.",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: _width * 0.036,
                    ),
                  ),
              )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: _width * 0.035),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(_width * 0.04),
                      margin: EdgeInsets.only(bottom: _height * 0.015),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_width * 0.035),
                        border: Border.all(
                          width: _width * 0.005,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "August 24 - 29",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              color: Pigment.fromString(CustomColors.grey3),
                              fontWeight: FontWeight.w400,
                              fontSize: _width * 0.04,
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.022,
                          ),
                          Text(
                            "Reserve 20 pods this week to get 50 points",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: _width * 0.04,
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.022,
                          ),
                          Text(
                            "10 pods reserved (minimum 20)",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              color: Pigment.fromString(CustomColors.grey16),
                              fontWeight: FontWeight.w600,
                              fontSize: _width * 0.03,
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.006,
                          ),
                          Container(
                            height: _height * 0.017,
                            child: FAProgressBar(
                              progressColor:
                                  Pigment.fromString(CustomColors.red6),
                              currentValue: 50,
                              borderRadius: _width,
                              backgroundColor: Colors.black.withOpacity(0.1),
                              maxValue: 100,
                              size: double.infinity,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
