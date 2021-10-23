import 'package:flutter/material.dart';
import 'package:urjaa/ui/themes/urjaa_theme.dart';
import 'package:urjaa/ui/urjaa_home/screens/urjaa_home.dart';

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: UrjaaTheme.background,
        appBarTheme: AppBarTheme(),
        textTheme: TextTheme(),
      ),
      home: HomePageWidget(),
    );
  }
}
