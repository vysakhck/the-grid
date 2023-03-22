import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:the_grid/screens/input_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Grid',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[900],
        textTheme: GoogleFonts.workSansTextTheme().copyWith(
          headline6: TextStyle(
            color: Colors.grey[900],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: Container(
        color: Colors.white,
        child: SplashScreen.navigate(
          name: 'assets/the_grid.riv',
          next: (_) => const InputScreen(),
          until: () => Future.delayed(const Duration(microseconds: 2400)),
          startAnimation: 'light_up',
        ),
      ),
    );
  }
}
