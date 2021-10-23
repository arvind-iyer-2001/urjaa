import 'package:flutter/material.dart';

class SomethingWrongApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text(
                'Something\'s wrong, I can feel it.\nTry reinstalling the application',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
