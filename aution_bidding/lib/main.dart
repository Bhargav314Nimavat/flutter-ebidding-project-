import 'package:flutter/material.dart';

import 'features/home/presentation/pages/offer_point_home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OfferPoint',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9AA7B8),
          brightness: Brightness.dark,
          surface: const Color(0xFF11161D),
        ),
        scaffoldBackgroundColor: const Color(0xFF090B10),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: const OfferPointHomeScreen(),
    );
  }
}