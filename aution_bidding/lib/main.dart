import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const BidSyncApp());
}

class BidSyncApp extends StatelessWidget {
  const BidSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BidSync',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0057B8),
          brightness: Brightness.light,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
