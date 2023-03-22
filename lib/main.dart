import 'package:flutter/material.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey[900],
      ),
      home: Container(
        color: Colors.white,
        child: SplashScreen.navigate(
          name: 'assets/the_grid.riv',
          next: (_) => Container(
            color: Colors.grey[300],
          ),
          until: () => Future.delayed(const Duration(microseconds: 2400)),
          startAnimation: 'light_up',
        ),
      ),
    );
  }
}
