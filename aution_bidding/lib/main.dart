import 'package:flutter/material.dart';

import 'features/home/presentation/pages/offer_point_home_screen.dart';

void main() {
  runApp(const BidSyncApp());
}

class BidSyncApp extends StatelessWidget {
  const BidSyncApp({super.key});

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
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),

      body: SafeArea(
        child: Stack(
          children: [

            /// CENTER CONTENT
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// LOGO
                  Image.asset(
                    'assets/images/logo.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 20),

                  /// TITLE
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xff0057B8),
                        Color(0xff11B5AE),
                      ],
                    ).createShader(bounds),

                    
                  ),

                  const SizedBox(height: 12),

                  /// TAGLINE
                
                  const SizedBox(height: 40),

                  /// LOADER
                  const SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xff0057B8),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// VERSION
                  const Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            /// COPYRIGHT BOTTOM
            const Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "© 2026 BidSync Technologies",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      home: const OfferPointHomeScreen(),
    );
  }
}