import 'package:calculadora_imc_flutter/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(47, 79, 79, 1)
        ),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const MainPage(),
    );
  }
}
