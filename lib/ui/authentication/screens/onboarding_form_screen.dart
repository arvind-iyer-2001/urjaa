import 'dart:io';

import 'package:flutter/material.dart';
import 'package:urjaa/backend/authentication/authentication_service.dart';

import 'package:urjaa/ui/themes/urjaa_theme.dart';

class OnboardingFormScreen extends StatefulWidget {
  @override
  _OnboardingFormScreenState createState() => _OnboardingFormScreenState();
}

class _OnboardingFormScreenState extends State<OnboardingFormScreen> {
  TextEditingController? _yourNameController;
  TextEditingController? _primaryContactController;
  TextEditingController? _ailmentsController;
  TextEditingController? _routineController;
  TextEditingController? _heightController;
  TextEditingController? _weightController;
  TextEditingController? _dobController;

  FocusNode? _yourNameFocusNode;
  FocusNode? _primaryContactFocusNode;
  FocusNode? _ailmentsFocusNode;
  FocusNode? _routineFocusNode;
  FocusNode? _heightFocusNode;
  FocusNode? _weightFocusNode;
  FocusNode? _dobFocusNode;

  final _formKey = GlobalKey<FormState>(debugLabel: 'Onboarding Form Key');

  FocusNode? emailFocusNode;

  @override
  void initState() {
    _yourNameController = new TextEditingController();
    _primaryContactController = new TextEditingController();
    _ailmentsController = new TextEditingController();
    _routineController = new TextEditingController();
    _heightController = new TextEditingController();
    _weightController = new TextEditingController();
    _dobController = new TextEditingController();

    _yourNameFocusNode = new FocusNode();
    _primaryContactFocusNode = new FocusNode();
    _ailmentsFocusNode = new FocusNode();
    _routineFocusNode = new FocusNode();
    _heightFocusNode = new FocusNode();
    _weightFocusNode = new FocusNode();
    _dobFocusNode = new FocusNode();

    super.initState();
  }

  void dispose() {
    _yourNameController!.dispose();
    _primaryContactController!.dispose();
    _ailmentsController!.dispose();
    _routineController!.dispose();
    _heightController!.dispose();
    _weightController!.dispose();
    _dobController!.dispose();
    _yourNameFocusNode!.dispose();
    _primaryContactFocusNode!.dispose();
    _ailmentsFocusNode!.dispose();
    _routineFocusNode!.dispose();
    _heightFocusNode!.dispose();
    _weightFocusNode!.dispose();
    _dobFocusNode!.dispose();
    super.dispose();
  }

  void submitForm() async {
    var _validForm = _formKey.currentState!.validate();
  }

  InputDecoration buildDecoration(
    String labelText,
    String hintText,
  ) {
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
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrjaaTheme.background,
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1F24),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: UrjaaTheme.grayLight,
            size: 32,
          ),
        ),
        title: Text(
          'Complete Profile',
          style: UrjaaTheme.title3.override(
            fontFamily: 'Lexend Deca',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              InkWell(
                onTap: () async {
                  // final selectedMedia =
                  //     await selectMediaWithSourceBottomSheet(
                  //   context: context,
                  // );
                  // if (selectedMedia != null &&
                  //     validateFileFormat(
                  //         selectedMedia.storagePath, context)) {
                  //   showUploadMessage(context, 'Uploading file...',
                  //       showLoading: true);

                  //   final result = FileUpload("").getPdfAndUpload();
                  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //   if (result != null) {
                  //     showUploadMessage(context, 'Success!');
                  //   } else {
                  //     showUploadMessage(context, 'Failed to upload media');
                  //     return;
                  //   }
                  // }
                },
                child: Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: FadeInImage(
                    image: AssetImage(
                      'assets/images/uiAvatar@2x.png',
                    ),
                    placeholder: AssetImage(
                      'assets/images/uiAvatar@2x.png',
                    ),
                  ),
                ),
              ),
              Text(
                'Upload a photo for us to easily identify you.',
                style: UrjaaTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  autofocus: true,
                  focusNode: emailFocusNode,
                  autocorrect: false,
                  onFieldSubmitted: (value) {
                    emailFocusNode!.unfocus();
                    FocusScope.of(context).requestFocus();
                  },
                  // controller: fullNameController,
                  obscureText: false,
                  decoration: buildDecoration('Name', 'name'),
                  validator: (String? fullName) {
                    if (fullName == null || fullName.isEmpty) {
                      return 'This Field is Required';
                    }
                    return 'Enter a Valid Name';
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
                    textStyle: MaterialStateProperty.resolveWith(
                      (states) {
                        return UrjaaTheme.subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: UrjaaTheme.textColor,
                        );
                      },
                    ),
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
                    foregroundColor:
                        MaterialStateProperty.resolveWith((states) {
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
      ),
    );
  }
}
