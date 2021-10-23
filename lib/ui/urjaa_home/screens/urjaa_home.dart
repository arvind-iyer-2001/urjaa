import 'package:firebase_auth/firebase_auth.dart';
import 'package:urjaa/backend/authentication/authentication_service.dart';
import 'package:urjaa/backend/database/user_database.dart';
import 'package:urjaa/models/user_data.dart';

import '../../themes/urjaa_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthenticationService().user,
      builder: (context, snapshot) {
        return StreamBuilder<UserData>(
          stream: UserDatabase(
            uid: snapshot.data!.uid,
          ).userData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: SpinKitPumpingHeart(
                    color: Color(0xFFFB5153),
                    size: 40,
                  ),
                ),
              );
            }
            final userData = snapshot.data;
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: UrjaaTheme.background,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: UrjaaTheme.primaryColor,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/UI_avatar_2@3x.png',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: Text(
                                'Greetings',
                                style: UrjaaTheme.title1.override(
                                  fontFamily: 'Lexend Deca',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: Text(
                                userData!.displayName,
                                style: UrjaaTheme.title2.override(
                                  fontFamily: 'Lexend Deca',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Image.asset(
                                'assets/images/waving-hand-sign_emoji-modifier-fitzpatrick-type-5_1f44b_1f3fe.png',
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                'Your next appointment',
                                style: UrjaaTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/noUpcomingAppointments.png',
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 56,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: UrjaaTheme.tertiaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: 720,
                                              // child: BookAppointmentWidget(),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Image.asset(
                                              'assets/images/iconCalendar.png',
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  12, 20, 12, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Book Appointment',
                                                    textAlign: TextAlign.start,
                                                    style: UrjaaTheme.title3
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 8),
                                                      child: Text(
                                                        'Schedule an appointment with our licensed professional.',
                                                        style: UrjaaTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color:
                                                              Color(0xB4FFFFFF),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: InkWell(
                                    onTap: () => setState(() {}),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: UrjaaTheme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 0, 0),
                                              child: Image.asset(
                                                'assets/images/iconPhone.png',
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    12, 20, 12, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Call the Office',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: UrjaaTheme.title3
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 8),
                                                        child: Text(
                                                          'Give us a call in order to schedule your appointment.',
                                                          style: UrjaaTheme
                                                              .bodyText2
                                                              .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Color(
                                                                0xB4FFFFFF),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: InkWell(
                                    onTap: () => setState(() {}),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: UrjaaTheme.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 0, 0),
                                              child: Image.asset(
                                                'assets/images/iconEmail.png',
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    12, 20, 12, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Email Us',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: UrjaaTheme.title3
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 8),
                                                        child: Text(
                                                          'Send us an email and we will get back to you within 2 days.',
                                                          style: UrjaaTheme
                                                              .bodyText2
                                                              .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Color(
                                                                0xB4FFFFFF),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
