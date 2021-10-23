import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:urjaa/backend/authentication/authentication_service.dart';
import 'package:urjaa/ui/themes/urjaa_theme.dart';

import './onboarding_form_screen.dart';

class EmailPhoneVerificationScreen extends StatefulWidget {
  const EmailPhoneVerificationScreen({
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
  final String phoneNumber;
  final String password;
  final String email;
  @override
  _EmailPhoneVerificationScreenState createState() =>
      _EmailPhoneVerificationScreenState();
}

class _EmailPhoneVerificationScreenState
    extends State<EmailPhoneVerificationScreen> {
  GlobalKey _otpKey = GlobalKey<FormState>();

  TextEditingController _otpController = new TextEditingController();
  FocusNode _otpFocusNode = new FocusNode();
  bool isCodeSent = false;
  String? verificationID;
  @override
  void initState() {
    _otpKey = GlobalKey<FormState>();
    _otpController = new TextEditingController();
    _otpFocusNode = new FocusNode();
    verifyPhone();
    // Start Phone verification by sending SMS
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();

    super.dispose();
  }

  void verifyOTPCode(
    String code,
  ) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID!,
      smsCode: code,
    );
    registerAndLinkPhoneCredentials(credential);
  }

  void registerAndLinkPhoneCredentials(
    PhoneAuthCredential phoneCredentials,
  ) async {
    try {
      if (_otpController.text.length == 6 && verificationID != null) {
        print(phoneCredentials);
        // Start Registration Process
        AuthenticationService().createAccount(
          email: widget.email,
          password: widget.password,
          phoneNumber: widget.phoneNumber,
          phoneCredentials: phoneCredentials,
        );
      }
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => OnboardingFormScreen(),
        ),
      );
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message!,
          ),
        ),
      );
    }
  }

  Future verifyPhone() async {
    try {
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: registerAndLinkPhoneCredentials,
        codeSent: (String verificationId, [int? forceResendingToken]) {
          setState(() {
            isCodeSent = true;
            print(verificationId);
            verificationID = verificationId;
          });
        },
        timeout: Duration(
          minutes: 2,
        ),
        codeAutoRetrievalTimeout: (verificationId) async {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Code has not been recieved',
              ),
            ),
          );
          setState(() {
            verificationID = verificationId;
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                exception.message!,
              ),
            ),
          );
        },
      );
    } on PlatformException catch (error) {
      errorHandler(error.message!);
    }
  }

  void errorHandler(String errorMessage) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 10,
        backgroundColor: UrjaaTheme.background,
        elevation: 0,
        title: Text(
          'Mobile Verification',
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: UrjaaTheme.background,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          height: 300,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 8,
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Enter the code sent to : \n",
                    children: [
                      TextSpan(
                        text: this.widget.phoneNumber,
                        style: UrjaaTheme.bodyText1.override(
                          fontSize: 20,
                          fontFamily: 'Lexend Deca',
                          color: UrjaaTheme.tertiaryColor,
                        ),
                      ),
                    ],
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Lexend Deca',
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: Form(
                  key: _otpKey,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    enablePinAutofill: true,
                    autoDismissKeyboard: true,
                    autoDisposeControllers: true,
                    hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                    keyboardType: TextInputType.number,
                    useHapticFeedback: true,
                    animationType: AnimationType.fade,
                    textStyle: TextStyle(color: Colors.white),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      borderWidth: 2,
                      fieldOuterPadding: EdgeInsets.symmetric(horizontal: 2),
                      inactiveColor: Colors.blueGrey,
                      activeColor: UrjaaTheme.tertiaryColor,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: false,
                    controller: _otpController,
                    onCompleted: (v) {
                      // validateCode();
                    },
                    onChanged: (value) {
                      print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ), // Submit Form Button
              Container(
                width: 230,
                child: ElevatedButton(
                  onPressed: () => verifyOTPCode(_otpController.text),
                  child: Text('Verify Phone'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return Color(0xFF2E53FC);
                      },
                    ),
                    textStyle: MaterialStateProperty.resolveWith((states) {
                      return UrjaaTheme.subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: UrjaaTheme.textColor,
                      );
                    }),
                    padding: MaterialStateProperty.resolveWith((states) {
                      return EdgeInsets.fromLTRB(0, 20, 0, 20);
                    }),
                    side: MaterialStateProperty.resolveWith(
                      (states) {
                        return BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        );
                      },
                    ),
                    elevation: MaterialStateProperty.resolveWith(
                      (states) {
                        return 10;
                      },
                    ),
                    shape: MaterialStateProperty.resolveWith(
                      (states) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
