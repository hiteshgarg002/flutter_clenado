import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clenado/blocs/promotions_bloc.dart';
import 'package:flutter_clenado/screens/drawer/promotions/promotions_screen.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/promotions_enum.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';

class PromotionsTabsScreen extends StatefulWidget {
  @override
  _PromotionsTabsScreenState createState() => _PromotionsTabsScreenState();
}

class _PromotionsTabsScreenState extends State<PromotionsTabsScreen> {
  double _height, _width;
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final List<Widget> _screensList = [
    BlocProvider(
      creator: (c, b) => PromotionsBloc(),
      child: PromotionsScreen(Promotions.CURRENT),
    ),
    BlocProvider(
      creator: (c, b) => PromotionsBloc(),
      child: PromotionsScreen(Promotions.PAST),
    ),
  ];

  PromotionsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<PromotionsBloc>(context);
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
                    "Promotions",
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

  Widget _buildTabWidget(int index, String title) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(_width),
          child: StreamBuilder<int>(
              initialData: 0,
              stream: _bloc.getScreen,
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: _height * 0.016),
                  decoration: BoxDecoration(
                    boxShadow: index == snapshot.data
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: _width * 0.011,
                              spreadRadius: _width * 0.001,
                            ),
                          ]
                        : [],
                    color: index == snapshot.data
                        ? Colors.white
                        : Pigment.fromString(CustomColors.grey5),
                    borderRadius: BorderRadius.circular(_width),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: index == snapshot.data
                          ? Colors.black
                          : Pigment.fromString(CustomColors.grey15),
                      fontWeight: FontWeight.w600,
                      fontSize: index == snapshot.data
                          ? _width * 0.036
                          : _width * 0.034,
                    ),
                  ),
                );
              }),
          onTap: () {
            _bloc.setScreen = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
            );
          },
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: _width * 0.02,
              vertical: _height * 0.015,
            ),
            padding: EdgeInsets.all(_width * 0.008),
            decoration: BoxDecoration(
              color: Pigment.fromString(CustomColors.grey5),
              borderRadius: BorderRadius.circular(_width),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: _buildTabWidget(0, "Current"),
                ),
                SizedBox(
                  width: _width * 0.01,
                ),
                Expanded(
                  child: _buildTabWidget(1, "Past"),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _screensList.length,
              itemBuilder: (BuildContext context, int index) =>
                  _screensList[index],
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
