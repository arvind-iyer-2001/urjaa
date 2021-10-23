import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:urjaa/backend/authentication/authentication_service.dart';
import '../misc/input_types.dart';
import '../../themes/urjaa_theme.dart';

class LoginPageView extends StatefulWidget {
  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController? emailOrPhoneLoginController;
  TextEditingController? passwordLoginController;

  GlobalKey _formKey = GlobalKey<FormState>();
  bool passwordLoginVisibility = false;

  FocusNode? emailOrPhoneFocusNode;
  FocusNode? passwordFocusNode;

  @override
  void initState() {
    emailOrPhoneLoginController = new TextEditingController();
    passwordLoginController = new TextEditingController();

    emailOrPhoneFocusNode = new FocusNode();
    passwordFocusNode = new FocusNode();
    super.initState();
  }

  void dispose() {
    passwordFocusNode!.dispose();
    emailOrPhoneFocusNode!.dispose();
    emailOrPhoneLoginController!.dispose();
    passwordLoginController!.dispose();
    super.dispose();
  }

  void signIn() async {
    AuthenticationService();
  }

  InputDecoration buildDecoration(
    InputType inputType,
  ) {
    String labelText = 'Text';
    String hintText = 'text';
    if (inputType == InputType.EmailOrPhoneNumber) {
      labelText = 'Email or Phone Number';
      hintText = 'email or phone number';
    } else if (inputType == InputType.Password) {
      labelText = 'Password';
      hintText = 'password';
    }
    return InputDecoration(
      labelText: labelText,
      labelStyle: UrjaaTheme.bodyText1.override(
        fontFamily: 'Lexend Deca',
        color: Color(0x98FFFFFF),
      ),
      hintText: 'Enter your $hintText...',
      hintStyle: UrjaaTheme.bodyText1.override(
        fontFamily: 'Lexend Deca',
        color: Color(0x98FFFFFF),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: UrjaaTheme.darkBackground,
      contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 30),
      suffixIcon: inputType == InputType.Password
          ? Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () => setState(
                  () => passwordLoginVisibility = !passwordLoginVisibility,
                ),
                child: Icon(
                  passwordLoginVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Color(0x98FFFFFF),
                  size: 20,
                ),
              ),
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 10,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextFormField(
                autofocus: true,
                focusNode: emailOrPhoneFocusNode,
                autocorrect: false,
                onFieldSubmitted: (value) {
                  emailOrPhoneFocusNode!.unfocus();
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                controller: emailOrPhoneLoginController,
                obscureText: false,
                decoration: buildDecoration(
                  InputType.EmailOrPhoneNumber,
                ),
                validator: (String? email) {
                  if (email == null || email.isEmpty) {
                    return 'This Field is Required';
                  }
                  bool validEmail = EmailValidator.validate(email);
                  if (!validEmail) {
                    return 'Enter a Valid Email and Phone Number';
                  }
                  return null;
                },
                style: UrjaaTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: UrjaaTheme.tertiaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextFormField(
                focusNode: passwordFocusNode,
                onFieldSubmitted: (value) {
                  passwordFocusNode!.unfocus();
                },
                controller: passwordLoginController,
                obscureText: !passwordLoginVisibility,
                decoration: buildDecoration(
                  InputType.Password,
                ),
                validator: (String? value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'This Field is Required';
                },
                style: UrjaaTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: UrjaaTheme.tertiaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
              width: 230,
              child: ElevatedButton(
                onPressed: () async {},
                child: Text('Login'),
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
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
                      if (states.contains(MaterialState.pressed)) {
                        return 0;
                      }
                      return 50;
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
            Container(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
              width: 230,
              child: TextButton(
                onPressed: () async {},
                child: Text('Forgot Password'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    return Colors.white;
                  }),
                  textStyle: MaterialStateProperty.resolveWith((states) {
                    return UrjaaTheme.subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                    );
                  }),
                  shape: MaterialStateProperty.resolveWith((states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    );
                  }),
                  padding: MaterialStateProperty.resolveWith((states) {
                    return EdgeInsets.fromLTRB(0, 20, 0, 20);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
