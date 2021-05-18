import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/painting.dart';
import 'package:books_app/widgets/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/utils/size_config.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _contactEditingController = new TextEditingController();
  String _dialCode = '';
  //Init AuthService
  final AuthService _authService = AuthService();

  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  //Alert dialogue to show error and response
  void showErrorDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Container(
        color: Color.fromRGBO(157, 206, 255, 1),
        child: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset('assets/library-01.png'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, right: 15.0),
                        child: _skipButton(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome to',
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Explr',
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Easiest way to exchange your books',
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  'with others',
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                _enterMobileNo(),
                SizedBox(height: 10),
                _sendOTP(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: 120,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      ' or you can ',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(height: 1, width: 120, color: Colors.black),
                  ],
                ),
                SizedBox(height: 20),
                _signUpwithEmail(),
                SizedBox(height: 10),
                _socialMediaHandles(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _enterMobileNo() {
    return Container(
      alignment: Alignment.center,
      height: 44,
      width: 260,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          CountryPicker(
            callBackFunction: _callBackFunction,
            headerText: 'Select Country',
            headerTextColor: Colors.black,
            headerBackgroundColor: Colors.black,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your Mobile',
                hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(7),
              ),
              controller: _contactEditingController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sendOTP() {
    return ButtonTheme(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(260, 44),
          elevation: 0.2,
          primary: Color(0xFF246BFD),
          onPrimary: Colors.white10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: () async {
          print('$_dialCode${_contactEditingController.text}');
          if (_contactEditingController.text.isEmpty) {
            showErrorDialog(context, 'Contact number can\'t be empty.');
          } else {
            final responseMessage = await Navigator.pushNamed(context, 'TO_DELETE', arguments: '$_dialCode${_contactEditingController.text}');
            if (responseMessage != null) {
              showErrorDialog(context, responseMessage as String);
            }
          }
        },
        child: Text(
          'Send OTP',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _signUpwithEmail() {
    return SizedBox(
      height: 44,
      width: 250,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Color(0xFF246BFD),
        ),
        onPressed: () async {
          Navigator.pushNamed(context, Routes.LOGIN);
        },
        icon: Icon(
          Icons.mail_outline_outlined,
          color: Colors.white,
        ),
        label: Text(
          'Sign up with email',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _socialMediaHandles() {
    return SizedBox(
      height: 44,
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 44,
            width: 110,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                side: BorderSide(color: Colors.black87),
              ),
              onPressed: () async {
                try {
                  dynamic res = await _authService.signInWithGoogle();
                  print(res);
                  if (res != null) {
                    print(res);
                    Navigator.pushNamed(context, Routes.HOME);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 44,
            width: 110,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                side: BorderSide(color: Colors.black87),
              ),
              onPressed: () async {
                AuthService().signInWithFacebook().whenComplete(() {
                  Navigator.pushNamed(context, Routes.HOME);
                });
              },
              child: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skipButton() {
    return ElevatedButton(
      onPressed: () {
        print('Skip button pressed');
      },
      style: ElevatedButton.styleFrom(
        primary: blackButton,
        onPrimary: Colors.white12,
        minimumSize: Size(55, 24.75),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        'Skip',
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
      ),
    );
  }
}
