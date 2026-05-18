import 'package:flutter/material.dart';

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
    );
  }
}