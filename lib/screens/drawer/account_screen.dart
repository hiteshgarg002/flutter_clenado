import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clenado/utils/custom_colors.dart';
import 'package:flutter_clenado/utils/theme_utils.dart';
import 'package:flutter_clenado/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pigment/pigment.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double _height, _width;

  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  final FocusNode _fNameFocusNode = FocusNode();
  final FocusNode _lNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();

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
          // color: Colors.white,
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
                          // color: Colors.black,
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
                    "Account",
                    style: GoogleFonts.inter(
                      // color: Colors.black,
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

  Widget _buildTextFieldWidget({
    @required String title,
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required String hint,
    bool obscureText = false,
    TextInputType inputType = TextInputType.text,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: _width * 0.015),
            child: Text(
              title,
              style: GoogleFonts.inter(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: _width * 0.042,
              ),
            ),
          ),
          SizedBox(
            height: _height * 0.007,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_width),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Pigment.fromString(CustomColors.black3)
                  : Pigment.fromString(CustomColors.grey1),
            ),
            child: TextField(
              obscureText: obscureText,
              controller: controller,
              focusNode: focusNode,
              style: GoogleFonts.inter(
                // color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: _width * 0.04,
              ),
              keyboardType: inputType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.inter(
                  color: Pigment.fromString(CustomColors.grey2),
                  fontWeight: FontWeight.w500,
                  fontSize: _width * 0.04,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: _width * 0.04,
                ),
              ),
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                Utils.removeFocus(context);
              },
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeUtils.getStatusNavBarTheme(context),
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: _buildAppbarWidget,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: _width * 0.055,
            vertical: _height * 0.02,
          ),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: _height * 0.03,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: _buildTextFieldWidget(
                      title: "First Name",
                      controller: _fNameController,
                      focusNode: _fNameFocusNode,
                      hint: "George",
                    ),
                  ),
                  SizedBox(width: _width * 0.04),
                  Expanded(
                    child: _buildTextFieldWidget(
                      title: "Last Name",
                      controller: _lNameController,
                      focusNode: _lNameFocusNode,
                      hint: "Msuku",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.05,
              ),
              _buildTextFieldWidget(
                title: "Email",
                controller: _emailController,
                focusNode: _emailFocusNode,
                hint: "georgemsuku30@gmail.com",
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: _height * 0.05,
              ),
              _buildTextFieldWidget(
                title: "Phone Number",
                controller: _mobileController,
                focusNode: _mobileFocusNode,
                hint: "+1 679-456-2987",
                inputType: TextInputType.phone,
              ),
              SizedBox(
                height: _height * 0.05,
              ),
              _buildTextFieldWidget(
                title: "Password",
                controller: _pwdController,
                focusNode: _pwdFocusNode,
                hint: "*********",
                inputType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(
                height: _height * 0.05,
              ),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  height: 0,
                  minWidth: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: _width * 0.11,
                    vertical: _height * 0.0245,
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Pigment.fromString(CustomColors.black1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_width),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text(
                    "Save Info",
                    style: GoogleFonts.inter(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: _width * 0.041,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _pwdController.dispose();

    _fNameFocusNode.dispose();
    _lNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _mobileFocusNode.dispose();
    _pwdFocusNode.dispose();
    super.dispose();
  }
}
