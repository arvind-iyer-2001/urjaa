import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

import 'package:password_strength/password_strength.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../misc/validators.dart';
import 'package:urjaa/ui/authentication/screens/email_phone_verification_screen.dart';
import '../misc/input_types.dart';
import '../../themes/urjaa_theme.dart';

class RegistrationPageView extends StatefulWidget {
  @override
  _RegistrationPageViewState createState() => _RegistrationPageViewState();
}

class _RegistrationPageViewState extends State<RegistrationPageView> {
  final _formKey = new GlobalKey<FormState>();
  // Text Input Controllers
  TextEditingController? emailLoginController;
  TextEditingController? phoneNumberLoginController;
  TextEditingController? passwordLoginController;
  TextEditingController? confirmPasswordLoginController;
  double passwordStrength = 0;
  // Password Visibility
  bool passwordLoginVisibility = false;
  bool confirmPasswordLoginVisibility = false;

  // Focus Nodes
  FocusNode? phoneNumberFocusNode;
  FocusNode? emailFocusNode;
  FocusNode? passwordFocusNode;
  FocusNode? confirmPasswordFocusNode;

  @override
  void initState() {
    emailLoginController = new TextEditingController();
    phoneNumberLoginController = new TextEditingController();
    passwordLoginController = new TextEditingController();
    confirmPasswordLoginController = new TextEditingController();

    phoneNumberFocusNode = new FocusNode();
    confirmPasswordFocusNode = new FocusNode();
    emailFocusNode = new FocusNode();
    passwordFocusNode = new FocusNode();

    super.initState();
  }

  void dispose() {
    emailLoginController!.dispose();
    confirmPasswordLoginController!.dispose();
    passwordLoginController!.dispose();
    phoneNumberLoginController!.dispose();
    passwordFocusNode!.dispose();
    emailFocusNode!.dispose();
    phoneNumberFocusNode!.dispose();
    confirmPasswordFocusNode!.dispose();
    super.dispose();
  }

  InputDecoration buildDecoration(
    InputType inputType,
  ) {
    String labelText = 'Text';
    String hintText = 'Enter your text';
    if (inputType == InputType.Email) {
      labelText = 'Email Address';
      hintText = 'Enter your email';
    } else if (inputType == InputType.EmailOrPhoneNumber) {
      labelText = 'Email or Phone Number';
      hintText = 'Enter your email or phone number';
    } else if (inputType == InputType.Password) {
      labelText = 'Password';
      hintText = 'Enter your password';
    } else if (inputType == InputType.PhoneNumber) {
      labelText = 'Phone Number';
      hintText = 'Enter your phone number';
    } else if (inputType == InputType.ConfirmPassword) {
      labelText = 'Confirm Password';
      hintText = 'Confirm your password';
    }

    return InputDecoration(
      labelText: labelText,
      labelStyle: UrjaaTheme.bodyText1.override(
        fontFamily: 'Lexend Deca',
        color: Color(0x98FFFFFF),
      ),
      hintText: hintText,
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
      suffixIcon: inputType == InputType.Password ||
              inputType == InputType.ConfirmPassword
          ? new Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () => setState(
                  () {
                    if (inputType == InputType.Password) {
                      passwordLoginVisibility = !passwordLoginVisibility;
                    }
                    if (inputType == InputType.ConfirmPassword) {
                      confirmPasswordLoginVisibility =
                          !confirmPasswordLoginVisibility;
                    }
                  },
                ),
                child: Icon(
                  (inputType == InputType.ConfirmPassword &&
                              confirmPasswordLoginVisibility) ||
                          (inputType == InputType.Password &&
                              passwordLoginVisibility)
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

  Future submitForm() async {
    try {
      final email = emailLoginController!.text.trim();
      final password = passwordLoginController!.text.trim();
      final phoneNumber = "+91 " + phoneNumberLoginController!.text;
      var _validForm = _formKey.currentState!.validate();
      var passwordMatch = await RegistrationFormValidators().passwordValidator(
        passwordLoginController!.text,
        confirmPasswordLoginController!.text,
      );
      var emailValid = await RegistrationFormValidators().emailValidator(
        email,
      );
      var phoneValid = await RegistrationFormValidators().phoneValidator(
        phoneNumber,
      );
      if (_validForm && passwordMatch && emailValid && phoneValid) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return EmailPhoneVerificationScreen(
                email: email,
                password: password,
                phoneNumber: phoneNumber,
              );
            },
          ),
        );
      }
    } catch (e) {
      print(e.hashCode);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
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
            // Email TextFormField
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextFormField(
                autofocus: true,
                autocorrect: false,
                focusNode: emailFocusNode,
                onFieldSubmitted: (value) {
                  emailFocusNode!.unfocus();
                  FocusScope.of(context).requestFocus(phoneNumberFocusNode);
                },
                controller: emailLoginController,
                obscureText: false,
                decoration: buildDecoration(
                  InputType.Email,
                ),
                validator: (String? email) {
                  if (email == null || email.isEmpty) {
                    return 'This Field is Required';
                  }
                  bool validEmail = EmailValidator.validate(email);
                  if (!validEmail) {
                    return 'Enter a Valid Email';
                  }
                  return null;
                },
                style: UrjaaTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: UrjaaTheme.tertiaryColor,
                ),
              ),
            ),
            // Phone Number TextFormField
            Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
              child: IntlPhoneField(
                textAlignVertical: TextAlignVertical.center,
                controller: phoneNumberLoginController,
                countryCodeTextColor: Color(0x98FFFFFF),
                initialCountryCode: "IN",
                focusNode: phoneNumberFocusNode,
                onChanged: (value) {
                  print(value.completeNumber);
                  print(phoneNumberLoginController!.text);
                },
                onSubmitted: (value) {
                  phoneNumberFocusNode!.unfocus();
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                iconPosition: IconPosition.trailing,
                obscureText: false,
                keyboardAppearance: Brightness.dark,
                dropDownIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Color(0x98FFFFFF),
                ),
                textInputAction: TextInputAction.next,
                decoration: buildDecoration(
                  InputType.PhoneNumber,
                ),
                keyboardType: TextInputType.phone,
                validator: (String? phoneNumber) {
                  if (phoneNumber == null) {
                    return 'This Field is Required';
                  }
                  if (phoneNumber.length < 7) {
                    return 'Enter a Valid Phone Number';
                  }
                },
                style: UrjaaTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: UrjaaTheme.tertiaryColor,
                ),
              ),
            ),
            // Password TextFormField
            Container(
              height: 130,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                children: [
                  TextFormField(
                    focusNode: passwordFocusNode,
                    onFieldSubmitted: (value) {
                      passwordFocusNode!.unfocus();
                      FocusScope.of(context)
                          .requestFocus(confirmPasswordFocusNode);
                    },
                    controller: passwordLoginController,
                    obscureText: !passwordLoginVisibility,
                    decoration: buildDecoration(
                      InputType.Password,
                    ),
                    onChanged: (password) {
                      setState(() {
                        passwordStrength = estimatePasswordStrength(password);
                      });
                    },
                    validator: (String? password) {
                      if (password == null || password.length < 8) {
                        return 'Password Must be atleast 8 Characters in Length';
                      }
                      if (estimatePasswordStrength(password) < 0.3) {
                        return 'Use a Stronger Password';
                      }
                      return null;
                    },
                    style: UrjaaTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: UrjaaTheme.tertiaryColor,
                    ),
                  ),
                  LinearProgressIndicator(
                    value: passwordStrength,
                    backgroundColor: Color.lerp(
                      Color(0xff8f0000),
                      Colors.lightBlueAccent,
                      passwordStrength.ceilToDouble(),
                    )!,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.lerp(
                        Color(0xff8f0000),
                        Color(0xff00ff00),
                        passwordStrength,
                      )!,
                    ),
                  ),
                ],
              ),
            ),
            // Confirm Password TextFormField
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextFormField(
                focusNode: confirmPasswordFocusNode,
                onFieldSubmitted: (value) {
                  passwordFocusNode!.unfocus();
                },
                controller: confirmPasswordLoginController,
                obscureText: !confirmPasswordLoginVisibility,
                decoration: buildDecoration(
                  InputType.ConfirmPassword,
                ),
                validator: (String? confirmedPassword) {
                  if (confirmedPassword == null) {
                    return 'This is not the same password as above';
                  }
                },
                style: UrjaaTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: UrjaaTheme.tertiaryColor,
                ),
              ),
            ),
            // Submit Form Button
            Container(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
              width: 230,
              child: ElevatedButton(
                onPressed: submitForm,
                child: Text('Create Account'),
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
    );
  }
}
