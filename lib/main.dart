import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'package:urjaa/material_apps/loading_application.dart';
import 'package:urjaa/ui/authentication/screens/onboarding_form_screen.dart';
import './material_apps/something_wrong_application.dart';
import './material_apps/main_application.dart';
import 'material_apps/authentication_application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<FirebaseApp> _initialization =
        Firebase.initializeApp().asStream();
    return MaterialApp(
      home: PageView(
        children: [
          OnboardingFormScreen(),
        ],
      ),
    );
    // return StreamBuilder(
    //   stream: _initialization,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return SomethingWrongApplication();
    //     }
    //     if (snapshot.connectionState == ConnectionState.done &&
    //         snapshot.hasData) {
    //       return StreamBuilder<User?>(
    //         stream: FirebaseAuth.instance.authStateChanges(),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState != ConnectionState.done ||
    //               !snapshot.hasData) {
    //             print(snapshot.data);
    //             return AuthenticationApplication();
    //           }
    //           return MainApplication();
    //         },
    //       );
    //     }
    //     return LoadingApplication();
    //   },
    // );
  }
}
