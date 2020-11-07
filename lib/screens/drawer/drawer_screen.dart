import 'dart:ui';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/blocs/drawer_bloc.dart';
import 'package:flutter_clenado/blocs/settings_bloc.dart';
import 'package:flutter_clenado/routes/routes.dart';
import 'package:flutter_clenado/utils/constants.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/shared_preferences_util.dart';
import 'package:flutter_clenado/utils/theme_utils.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pigment/pigment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  PageController _pageController;
  final PanelController _panelController = PanelController();
  final ScrollController _scrollController = ScrollController();

  String _mapStyleLight, _mapStyleDark;

  //  Object for PolylinePoints
  PolylinePoints _polylinePoints;

  // List of coordinates to join
  List<LatLng> _polylineCoordinates = [];

  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> _polylines = {};

  DateTime _from, _to;
  int _hours;

  SharedPreferences _preferences;

  SettingsBloc _settingsBloc;
  DrawerBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<DrawerBloc>(context);
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);

    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 0.9,
    );

    _setPodsMarkers();
    _setThemeModeListener();
  }

  void _setThemeModeListener() {
    _settingsBloc.darkMode.listen((isDarkMode) {
      if (isDarkMode != null && _mapController != null) {
        if (isDarkMode) {
          if (_mapStyleDark != null) {
            _mapController.setMapStyle(_mapStyleDark);
          }
        } else {
          if (_mapStyleLight != null) {
            _mapController.setMapStyle(_mapStyleLight);
          }
        }
      }
    });
  }

  Future<void> _setupSharedPreferences() async {
    _preferences = await SharedPreferencesUtil.getSharedPreferences();
  }

  Future<void> _getMapStyles() async {
    _mapStyleLight = await rootBundle.loadString(
      'assets/maps_style/maps_style_light.txt',
      cache: true,
    );

    _mapStyleDark = await rootBundle.loadString(
      'assets/maps_style/maps_style_dark.txt',
      cache: true,
    );
  }

  Future<void> _getMarkerIcon() async {
    _bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/marker.png",
    );
  }

  Future<void> _setPodsMarkers() async {
    await _setupSharedPreferences();

    await _getMapStyles();
    await _getMarkerIcon();

    _markersList = Set();

    _markersList.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(22.7533, 75.8937),
        icon: _bitmapDescriptor,
        onTap: () async {
          _panelController.open();
        },
      ),
    );

    _markersList.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(22.7244, 75.8839),
        icon: _bitmapDescriptor,
        onTap: () async {
          _panelController.open();
        },
      ),
    );

    // _createPolylines(
    //   Position(latitude: 22.7533, longitude: 75.8937),
    //   Position(latitude: 22.7244, longitude: 75.8839),
    // );

    await Future.delayed(Duration(seconds: 2));
    _bloc.setLoading = false;
  }

  Future<void> _createPolylines(Position start, Position destination) async {
    // Initializing PolylinePoints
    _polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      Constants.GOOGLE_MAPS_API_KEY, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: _polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    _polylines[id] = polyline;
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
            color: Theme.of(context).scaffoldBackgroundColor,
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
                  // color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: _width * 0.04,
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              FlatButton(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                splashColor: Colors.white.withOpacity(0.4),
                child: Text(
                  "Go to App Settings",
                  style: GoogleFonts.inter(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
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
                    color: Colors.black,
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
                    color: Colors.black,
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
              vertical: _height * 0.0175,
              horizontal: _width * 0.07,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                // color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: smallSize ? _width * 0.046 : _width * 0.052,
              ),
            ),
          ),
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 150));
            Navigator.pop(context);
            await Future.delayed(Duration(milliseconds: 250));

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

              case 7:
                Routes.settingsScreen(context);
                break;
            }
          },
        ),
      );

  Widget get _buildDrawerWidget => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top * 1.3,
          ),
          Padding(
            padding: EdgeInsets.only(left: _width * 0.04),
            child: MaterialButton(
              height: 0,
              minWidth: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: CircleBorder(),
              padding: EdgeInsets.all(_width * 0.015),
              child: Icon(
                Icons.close,
                size: _width * 0.08,
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
                      padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
                      child: Divider(
                        height: 0,
                        endIndent: 0,
                        indent: 0,
                        thickness: _height * 0.0014,
                        color: Pigment.fromString(CustomColors.grey22),
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
                      height: _height * 0.036,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: _width * 0.05),
                      child: MaterialButton(
                        height: 0,
                        minWidth: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: _width * 0.1,
                          vertical: _height * 0.022,
                        ),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Pigment.fromString(CustomColors.black1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_width),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text(
                          "Sign out",
                          style: GoogleFonts.inter(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
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
          color: Colors.black,
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

  Widget get _buildSheetReserveNowButtonWidget => MaterialButton(
        height: 0,
        minWidth: _width * 0.78,
        padding: EdgeInsets.symmetric(
          vertical: _height * 0.025,
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
            fontSize: _width * 0.04,
          ),
        ),
        onPressed: () async {
          await Future.delayed(Duration(milliseconds: 150));

          await _panelController.close();
          Routes.codeScreen(context);
        },
      );

  Widget get _buildReserveNowButtonWidget => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.095,
          vertical: _height * 0.0225,
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
            fontWeight: FontWeight.w900,
            fontSize: _width * 0.037,
          ),
        ),
        onPressed: () async {
          await Future.delayed(Duration(milliseconds: 150));

          _showPodsNearYouSheet();
        },
      );

  Widget _buildDateCostWidget({
    @required CrossAxisAlignment crossAxisAlignment,
    @required String title,
    @required int dateType,
  }) {
    Widget valueWidget;

    switch (dateType) {
      case 0:
        valueWidget = StreamBuilder<DateTime>(
          initialData: null,
          stream: _bloc.getFrom,
          builder: (context, snapshot) {
            _from = snapshot.data;
            String value1, value2;

            if (snapshot.data == null) {
              value1 = "-";
              value2 = "-";
            } else {
              DateTime dateTime = snapshot.data;

              value1 = dateTime.day.toString();
              value2 = DateFormat("MMM").format(dateTime);
            }

            return RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: value1,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: _width * 0.085,
                ),
                children: [
                  TextSpan(
                    text: value2,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: _width * 0.035,
                    ),
                  )
                ],
              ),
            );
          },
        );

        break;
      case 1:
        valueWidget = StreamBuilder<DateTime>(
          initialData: null,
          stream: _bloc.getTo,
          builder: (context, snapshot) {
            _to = snapshot.data;
            String value1, value2;

            if (snapshot.data == null) {
              value1 = "-";
              value2 = "-";
            } else {
              DateTime dateTime = snapshot.data;

              value1 = dateTime.day.toString();
              value2 = DateFormat("MMM").format(dateTime);
            }

            return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: value1,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: _width * 0.085,
                ),
                children: [
                  TextSpan(
                    text: value2,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: _width * 0.035,
                    ),
                  ),
                ],
              ),
            );
          },
        );

        break;
      default:
        valueWidget = StreamBuilder<int>(
          initialData: null,
          stream: _bloc.getHours,
          builder: (context, snapshot) {
            _hours = snapshot.data;
            String value1, value2;

            if (snapshot.data == null) {
              value1 = "-";
              value2 = "-";
            } else {
              int hours = snapshot.data;

              value1 = hours.toString();
              value2 = "HR";

              _bloc.setAmount = hours * 2.50;
            }

            return RichText(
              maxLines: 1,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: value1,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: _width * 0.065,
                ),
                children: [
                  TextSpan(
                    text: value2,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: _width * 0.025,
                    ),
                  ),
                ],
              ),
            );
          },
        );
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.start,
          style: GoogleFonts.inter(
            color: Pigment.fromString(CustomColors.grey19),
            fontWeight: FontWeight.w500,
            fontSize: _width * 0.037,
          ),
        ),
        SizedBox(
          height: _height * 0.012,
        ),
        valueWidget,
      ],
    );
  }

  Future<DateTime> _showDatePicker(DateTime initialDate) async {
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10),
        builder: (context, datePicker) {
          return Theme(
            data: ThemeData(
              primarySwatch: ColorToMaterial(
                Pigment.fromString(CustomColors.black1),
              ).getMaterialColor(),
            ),
            child: datePicker,
          );
        });

    return dateTime;
  }

  Widget get _buildCalendarDaysCostWidget => Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: _width * 0.017),
              child: Text(
                "Select a Date",
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  // color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: _width * 0.04,
                ),
              ),
            ),
          ),
          SizedBox(
            height: _height * 0.017,
          ),
          Container(
            decoration: BoxDecoration(
              color: Pigment.fromString(CustomColors.grey12),
              borderRadius: BorderRadius.circular(_width * 0.035),
            ),
            padding: EdgeInsets.all(_width * 0.055),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: _buildDateCostWidget(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      dateType: 0,
                      title: "FROM",
                    ),
                    onTap: () async {
                      DateTime dateTime = await _showDatePicker(_from);

                      if (dateTime != null) {
                        _bloc.setFrom = dateTime;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: _buildDateCostWidget(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      dateType: 1,
                      title: "TO",
                    ),
                    onTap: () async {
                      DateTime dateTime = await _showDatePicker(_to);

                      if (dateTime != null) {
                        _bloc.setTo = dateTime;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: _buildDateCostWidget(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    dateType: null,
                    title: "TOTAL",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: _height * 0.07,
          ),
          StreamBuilder<double>(
              initialData: 0,
              stream: _bloc.getAmount,
              builder: (context, snapshot) {
                return Text(
                  "Total charge: \$${snapshot.data}",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    // color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: _width * 0.048,
                  ),
                );
              }),
          SizedBox(
            height: _height * 0.025,
          ),
          _buildSheetReserveNowButtonWidget,
        ],
      );

  Widget get _buildSlidingPanelWidget => SlidingUpPanel(
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.white,
        controller: _panelController,
        defaultPanelState: PanelState.CLOSED,
        backdropEnabled: true,
        minHeight: 0,
        maxHeight: _height * 0.75,
        onPanelClosed: () {
          _bloc.setFrom = null;
          _bloc.setTo = null;
          _bloc.setAmount = 0;

          _scrollController.jumpTo(0);
        },
        footer: Container(),
        header: Container(
          width: _width,
          height: _height * 0.05,
          alignment: Alignment.center,
          child: Container(
            height: _height * 0.005,
            width: _width * 0.35,
            decoration: BoxDecoration(
              color: Pigment.fromString(CustomColors.grey12),
              borderRadius: BorderRadius.circular(_width),
            ),
          ),
        ),
        isDraggable: true,
        panel: Container(
          height: _height * 0.75,
          width: _width,
          padding: EdgeInsets.only(
            top: _height * 0.05,
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();

              return true;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                          height: _height * 0.043,
                        ),
                        _buildCalendarDaysCostWidget,
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
        ),
      );

  Widget _buildNavigateIconButtonWidget() => MaterialButton(
        height: 0,
        minWidth: 0,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.045,
          vertical: _height * 0.018,
        ),
        color: Pigment.fromString(CustomColors.red7),
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
              width: _width * 0.042,
              height: _width * 0.042,
            ),
            SizedBox(width: _width * 0.022),
            Text(
              "Navigate",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: _width * 0.042,
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
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          height: _height * 0.09,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: _height * 0.09,
                      padding: EdgeInsets.symmetric(
                        horizontal: _width * 0.04,
                        // vertical: _height * 0.015,
                      ),
                      alignment: Alignment.centerLeft,
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
                                    fontSize: _width * 0.042,
                                  ),
                                ),
                                SizedBox(height: _height * 0.002),
                                Text(
                                  "1667 K Street NW",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: _width * 0.03,
                                  ),
                                ),
                                SizedBox(height: _height * 0.002),
                                Text(
                                  "1.9 miles",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: _width * 0.028,
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
                  ],
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
                  // color: Colors.black,
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
                    zoom: 12.5,
                  ),
                  // polylines: Set<Polyline>.of(_polylines.values),
                  markers: _markersList,
                  buildingsEnabled: true,
                  compassEnabled: false,
                  zoomGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  onCameraMove: (CameraPosition position) {},
                  onMapCreated: (controller) {
                    bool isDarkMode =
                        _preferences.getBool("darkMode") != null &&
                            _preferences.getBool("darkMode");

                    if (isDarkMode) {
                      controller.setMapStyle(_mapStyleDark);
                    } else {
                      controller.setMapStyle(_mapStyleLight);
                    }

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
        },
      );

  Widget get _buildContentWidget => Stack(
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
                  _buildReserveNowButtonWidget,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _buildMyLocationButtonWidget,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildSlidingPanelWidget,
          ),
        ],
      );

  Widget get _buildCircularProgressWidget => Center(
        child: CircularProgressIndicator(
          strokeWidth: _width * 0.008,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/sample_image.jpg"), context);

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: WillPopScope(
        child: Scaffold(
          key: _sfKey,
          // backgroundColor: Colors.white,
          body: StreamBuilder<bool>(
              initialData: true,
              stream: _bloc.getLoading,
              builder: (context, snapshot) {
                return snapshot.data
                    ? _buildCircularProgressWidget
                    : _buildContentWidget;
              }),
          drawer: Container(
            width: double.infinity,
            height: double.infinity,
            child: Drawer(
              child: _buildDrawerWidget,
            ),
          ),
        ),
        onWillPop: () {
          if (_panelController.isPanelOpen) {
            _panelController.close();
            return Future.value(false);
          }

          return Future.value(true);
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _scrollController..dispose();

    super.dispose();
  }
}

// Draw routes between two coordinates
// https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/
