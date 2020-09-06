import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/blocs/drawer_bloc.dart';
import 'package:flutter_clenado/routes/routes.dart';
import 'package:flutter_clenado/utils/calendar/table_calendar.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pigment/pigment.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  double _height, _width;
  GoogleMapController _mapController;

  final GlobalKey<ScaffoldState> _sfKey = GlobalKey();
  Set<Marker> _markersList;

  BitmapDescriptor _bitmapDescriptor;

  CalendarController _calendarController;
  PageController _pageController;

  DrawerBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<DrawerBloc>(context);
    _calendarController = CalendarController();

    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 0.9,
    );

    _setPodsMarkers();
  }

  Future<void> _getMarkerIcon() async {
    _bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/marker.png",
    );
  }

  Future<void> _setPodsMarkers() async {
    await _getMarkerIcon();
    _markersList = Set();

    _markersList.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(22.7533, 75.8937),
        icon: _bitmapDescriptor,
        onTap: () async {
          await _showReservationDetailsSheet();
        },
      ),
    );

    _markersList.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(22.7244, 75.8839),
        icon: _bitmapDescriptor,
        onTap: () async {
          await _showReservationDetailsSheet();
        },
      ),
    );

    await Future.delayed(Duration(seconds: 2));
    _bloc.setLoading = false;
  }

  void _showAppSettingsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: _height * 0.02,
            horizontal: _width * 0.1,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(_width * 0.03),
              topLeft: Radius.circular(_width * 0.03),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Please enable location permission and try again!",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: _width * 0.04,
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              FlatButton(
                color: Colors.black,
                splashColor: Colors.white.withOpacity(0.4),
                child: Text(
                  "Go to App Settings",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: _width * 0.038,
                  ),
                ),
                onPressed: () async {
                  await Future.delayed(Duration(milliseconds: 100));

                  openAppSettings();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _isPermissionGranted() async {
    LocationPermission permission = await checkPermission();

    if (permission == LocationPermission.deniedForever) {
      // show dialog for navigating to app settings
      _showAppSettingsDialog();

      return false;
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }

    LocationPermission requestedPermission = await requestPermission();

    if (requestedPermission == LocationPermission.denied ||
        requestedPermission == LocationPermission.deniedForever) {
      return false;
    } else {
      return true;
    }
  }

  Future<Position> _getCurrentLocation() async {
    try {
      bool isPermissionGranted = await _isPermissionGranted();

      if (!isPermissionGranted) {
        return null;
      }

      Position position = await getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      return position;
    } catch (err) {
      print("Error :: _getCurrentLocation :: ${err.toString()}");
      return null;
    }
  }

  Widget get _buildAppbarWidget => PreferredSize(
        child: Container(
          height: AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  elevation: 5,
                  height: 0,
                  minWidth: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(_width * 0.015),
                  color: Colors.white,
                  child: Icon(
                    Icons.menu,
                    size: _width * 0.07,
                  ),
                  onPressed: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _sfKey.currentState.openDrawer();
                  },
                ),
                MaterialButton(
                  elevation: 5,
                  height: 0,
                  minWidth: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(_width * 0.015),
                  color: Colors.white,
                  child: Icon(
                    Icons.card_giftcard,
                    size: _width * 0.07,
                  ),
                  onPressed: () async {
                    await Future.delayed(Duration(milliseconds: 150));
                    Routes.inviteScreen(context);
                  },
                ),
              ],
            ),
          ),
        ),
        preferredSize: AppBar().preferredSize,
      );

  Widget _buildDrawerItemWidget(int index, String title,
          {bool smallSize = false, FontWeight fontWeight = FontWeight.w900}) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: _height * 0.017,
              horizontal: _width * 0.06,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: smallSize ? _width * 0.043 : _width * 0.05,
              ),
            ),
          ),
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 150));
            Navigator.pop(context);
            await Future.delayed(Duration(milliseconds: 200));

            switch (index) {
              case 0:
                Routes.accountScreen(context);
                break;

              case 1:
                Routes.reservationsScreen(context);
                break;

              case 2:
                Routes.promotionsTabsScreen(context);
                break;

              case 3:
                Routes.historyScreen(context);
                break;

              case 4:
                Routes.walletScreen(context);
                break;

              case 5:
                Routes.rewardsPointsScreen(context);
                break;

              case 6:
                Routes.helpScreen(context);
                break;
            }
          },
        ),
      );

  Widget get _buildDrawerWidget => Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top * 1.3,
            ),
            Padding(
              padding: EdgeInsets.only(left: _width * 0.03),
              child: MaterialButton(
                height: 0,
                minWidth: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
            SizedBox(
              height: _height * 0.04,
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildDrawerItemWidget(0, "Account"),
                      _buildDrawerItemWidget(1, "Reservations"),
                      _buildDrawerItemWidget(2, "Promotions"),
                      _buildDrawerItemWidget(3, "History"),
                      _buildDrawerItemWidget(4, "Wallet"),
                      _buildDrawerItemWidget(5, "Rewards & points"),
                      SizedBox(
                        height: _height * 0.12,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: _width * 0.06),
                        child: Divider(
                          height: 0,
                          endIndent: 0,
                          indent: 0,
                          thickness: _height * 0.0015,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.04,
                      ),
                      _buildDrawerItemWidget(
                        6,
                        "Help",
                        smallSize: true,
                        fontWeight: FontWeight.bold,
                      ),
                      _buildDrawerItemWidget(
                        7,
                        "Settings",
                        smallSize: true,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: _height * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: _width * 0.06),
                        child: MaterialButton(
                          height: 0,
                          minWidth: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: _width * 0.06,
                            vertical: _height * 0.015,
                          ),
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_width),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: Text(
                            "Sign out",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: _width * 0.035,
                            ),
                          ),
                          onPressed: () async {
                            await Future.delayed(Duration(milliseconds: 150));
                            Routes.loginScreen(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget get _buildMyLocationButtonWidget => MaterialButton(
        elevation: 5,
        height: 0,
        minWidth: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: CircleBorder(),
        padding: EdgeInsets.all(_width * 0.015),
        color: Colors.white,
        child: Icon(
          Icons.my_location,
          size: _width * 0.07,
        ),
        onPressed: () async {
          Position position = await _getCurrentLocation();

          if (position != null) {
            _mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 15.0,
                ),
              ),
            );
          }
        },
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

  Widget _buildNavigateButtonWidget() => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.05,
          vertical: _height * 0.01,
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

  Widget _buildReserveNowButtonWidget({bool onSheet = false}) => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.05,
          vertical: _height * 0.018,
        ),
        color: Pigment.fromString(CustomColors.red1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          "Reserve Now",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: _width * 0.034,
          ),
        ),
        onPressed: () async {
          await Future.delayed(Duration(milliseconds: 150));

          if (!onSheet) {
            _showPodsNearYouSheet();
          } else {
            Navigator.pop(context);
            await Future.delayed(Duration(milliseconds: 300));
            Routes.codeScreen(context);
          }
        },
      );

  Widget get _buildCalendarWidget => TableCalendar(
        calendarController: _calendarController,
        initialCalendarFormat: CalendarFormat.month,
        availableGestures: AvailableGestures.none,
        availableCalendarFormats: {CalendarFormat.month: 'Month'},
        rowHeight: _height * 0.045,
        startDay: DateTime.now(),
        initialSelectedDay: DateTime.now(),
        onDaySelected: (dateTime, list) {
          print(dateTime.toString());
        },
        calendarStyle: CalendarStyle(
          contentPadding: EdgeInsets.zero,
          highlightToday: false,
          highlightSelected: false,
          outsideDaysVisible: false,
          weekdayStyle: GoogleFonts.inter(
            color: Pigment.fromString(CustomColors.grey8),
            fontWeight: FontWeight.w800,
            fontSize: _width * 0.038,
          ),
          weekendStyle: GoogleFonts.inter(
            color: Pigment.fromString(CustomColors.grey8),
            fontWeight: FontWeight.w800,
            fontSize: _width * 0.038,
          ),
          holidayStyle: GoogleFonts.inter(
            color: Pigment.fromString(CustomColors.grey8),
            fontWeight: FontWeight.w800,
            fontSize: _width * 0.038,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextBuilder: (dateTime, _) {
            return DateFormat('E').format(dateTime)[0];
          },
          weekdayStyle: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: _width * 0.038,
          ),
          weekendStyle: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: _width * 0.038,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          formatButtonShowsNext: false,
          centerHeaderTitle: true,
          formatButtonPadding: EdgeInsets.zero,
          headerPadding: EdgeInsets.zero,
          leftChevronMargin: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          leftChevronPadding: EdgeInsets.zero,
          rightChevronPadding: EdgeInsets.zero,
          headerMargin: EdgeInsets.only(bottom: _height * 0.03),
          titleTextStyle: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: _width * 0.038,
          ),
        ),
        builders: CalendarBuilders(
          selectedDayBuilder: (context, dateTime, list) {
            return Container(
              decoration: BoxDecoration(
                color: Pigment.fromString(CustomColors.red4),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                dateTime.day.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: _width * 0.038,
                ),
              ),
            );
          },
        ),
      );

  Future<void> _showReservationDetailsSheet() async {
    return await showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      enableDrag: true,
      isDismissible: false,
      bounce: true,
      expand: false,
      builder: (BuildContext context, ScrollController controller) {
        return Container(
          height: _height * 0.7,
          width: double.infinity,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();

              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Container(
                    height: _height * 0.005,
                    width: _width * 0.35,
                    decoration: BoxDecoration(
                      color: Pigment.fromString(CustomColors.grey12),
                      borderRadius: BorderRadius.circular(_width),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
                    child: Text(
                      "Washignton DC",
                      style: GoogleFonts.inter(
                        color: Colors.black,
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
                            color: Colors.black,
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
                                color: Colors.black,
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
                                "Charging ports per bay:",
                                "20",
                              ),
                              SizedBox(
                                height: _height * 0.025,
                              ),
                              _buildBottomSheetInfoRowWidget(
                                "Reservation starts:",
                                "On time & date",
                              ),
                              SizedBox(
                                height: _height * 0.025,
                              ),
                              _buildBottomSheetInfoRowWidget(
                                "Reservation ends:",
                                "12 hrs after",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.05,
                        ),
                        _buildCalendarWidget,
                        SizedBox(
                          height: _height * 0.02,
                        ),
                        Text(
                          "7 days selected",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: _width * 0.034,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.04,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Total charge: \$210",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: _width * 0.036,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: _width * 0.03,
                            ),
                            _buildReserveNowButtonWidget(onSheet: true),
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.03,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigateIconButtonWidget() => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.04,
          vertical: _height * 0.015,
        ),
        color: Pigment.fromString(CustomColors.red1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/navigate.webp",
              width: _width * 0.03,
              height: _width * 0.03,
            ),
            SizedBox(width: _width * 0.02),
            Text(
              "Navigate",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: _width * 0.033,
              ),
            ),
          ],
        ),
        onPressed: () {},
      );

  Widget _buildPodsNearYouItemWidget() => Container(
        width: _width,
        height: _height * 0.25,
        margin: EdgeInsets.symmetric(horizontal: _width * 0.015),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_width * 0.04),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_width * 0.035),
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/sample_image.jpg"),
                width: _width,
                height: _height * 0.25,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(_width * 0.04),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Washignton DC",
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: _width * 0.04,
                              ),
                            ),
                            Text(
                              "1667 K Street NW",
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: _width * 0.028,
                              ),
                            ),
                            Text(
                              "1.9 miles",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: _width * 0.026,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: _width * 0.03,
                      ),
                      _buildNavigateIconButtonWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _showPodsNearYouSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _height * 0.02,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: _height * 0.006,
                width: _width * 0.35,
                decoration: BoxDecoration(
                  color: Pigment.fromString(CustomColors.grey12),
                  borderRadius: BorderRadius.circular(_width),
                ),
              ),
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
              child: Text(
                "Pods near you",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: _width * 0.048,
                ),
              ),
            ),
            Container(
              width: _width,
              height: _height * 0.25,
              margin: EdgeInsets.symmetric(vertical: _height * 0.025),
              child: PageView.builder(
                controller: _pageController,
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                itemBuilder: (BuildContext context, int index) {
                  return _buildPodsNearYouItemWidget();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget get _buildGoogleMapsWidget => StreamBuilder<bool>(
      initialData: false,
      stream: _bloc.getIsMapReady,
      builder: (context, snapshot) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: snapshot.data ? 1.0 : 0.0,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(22.7533, 75.8937),
                ),
                markers: _markersList,
                buildingsEnabled: true,
                compassEnabled: false,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                indoorViewEnabled: true,
                onCameraMove: (CameraPosition position) {},
                onMapCreated: (controller) {
                  this._mapController = controller;
                  Future.delayed(
                    Duration(milliseconds: 500),
                    () => _bloc.setIsMapReady = true,
                  );
                },
                padding: EdgeInsets.zero,
              ),
            ),
            if (snapshot.data)
              SizedBox.shrink()
            else
              _buildCircularProgressWidget,
          ],
        );
      });

  Widget get _buildCircularProgressWidget => Center(
        child: CircularProgressIndicator(
          strokeWidth: _width * 0.008,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/sample_image.jpg"), context);

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: _sfKey,
        backgroundColor: Colors.white,
        body: StreamBuilder<bool>(
            initialData: true,
            stream: _bloc.getLoading,
            builder: (context, snapshot) {
              return snapshot.data
                  ? _buildCircularProgressWidget
                  : Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        _buildGoogleMapsWidget,
                        Align(
                          alignment: Alignment.topCenter,
                          child: _buildAppbarWidget,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: _height * 0.03,
                              right: _width * 0.05,
                              left: _width * 0.05,
                            ),
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                _buildReserveNowButtonWidget(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: _buildMyLocationButtonWidget,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            }),
        drawer: Container(
          width: double.infinity,
          height: double.infinity,
          child: Drawer(
            child: _buildDrawerWidget,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _calendarController.dispose();
    super.dispose();
  }
}

// Draw routes between two coordinates
// https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/

//
// http://www.perchmobility.com/
// https://www.charge.us/
