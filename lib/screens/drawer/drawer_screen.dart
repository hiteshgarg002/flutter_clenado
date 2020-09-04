import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/blocs/drawer_bloc.dart';
import 'package:flutter_clenado/routes/routes.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  DrawerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<DrawerBloc>(context);

    _markersList = Set();

    Future.delayed(
      Duration(seconds: 2),
      () => _bloc.setLoading = false,
    );
  }

  Future<BitmapDescriptor> _getMarkerIcon() async {
    _bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/marker.webp",
    );
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

              case 3:
                Routes.historyScreen(context);
                break;

              case 4:
                Routes.walletScreen(context);
                break;

              case 5:
                Routes.rewardsPointsScreen(context);
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
                          onPressed: () {},
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

  Widget get _buildReserveButtonWidget => MaterialButton(
        elevation: 5,
        height: 0,
        minWidth: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_width),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.08,
          vertical: _height * 0.02,
        ),
        color: Pigment.fromString(CustomColors.red1),
        child: Text(
          "Reserve Now",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: _width * 0.035,
          ),
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
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(0, 0),
                          ),
                          markers: _markersList,
                          buildingsEnabled: true,
                          compassEnabled: true,
                          zoomGesturesEnabled: true,
                          rotateGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          tiltGesturesEnabled: true,
                          myLocationEnabled: false,
                          zoomControlsEnabled: false,
                          onMapCreated: (controller) {
                            this._mapController = controller;
                          },
                          padding: EdgeInsets.zero,
                        ),
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
                                _buildReserveButtonWidget,
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
    super.dispose();
  }
}
