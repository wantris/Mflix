import 'package:flutter/material.dart';
import 'package:movie_db/constants/constant.dart';
import 'main_sreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Move DB',
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.backgroundColor,
        textTheme: GoogleFonts.ubuntuTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
