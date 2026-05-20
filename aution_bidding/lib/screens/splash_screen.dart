import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        // Navigate Here
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              /// MAIN CENTER
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// LOGO
                      Container(
                        height: 170,
                        width: 170,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white10,
                          border: Border.all(
                            color: Colors.white24,
                            width: 2,
                          ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(28),

                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// TITLE
                      const Text(
                        "BANKMATE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// SUBTITLE
                      const Text(
                        "Mortgage Bidding System",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// LOADER
                      const SizedBox(
                        height: 35,
                        width: 35,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// BOTTOM TEXT
              const Column(
                children: [

                  Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "© 2026 BankMate",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
