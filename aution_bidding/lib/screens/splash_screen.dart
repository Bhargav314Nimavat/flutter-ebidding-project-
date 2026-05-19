import 'dart:async';
import 'package:flutter/material.dart';

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
        // Navigate to next screen
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomeScreen(),
        //   ),
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff001B5E),
              Color(0xff0039A6),
              Color(0xff001B5E),
            ],
          ),
        ),

        child: Stack(
          children: [

            /// WORLD MAP BACKGROUND EFFECT
            Positioned(
              bottom: 80,
              left: -20,
              right: -20,
              child: Opacity(
                opacity: 0.08,
                child: Icon(
                  Icons.public,
                  size: 350,
                  color: Colors.white,
                ),
              ),
            ),

            /// MAIN CONTENT
          SafeArea(
  child: SingleChildScrollView(
    child: SizedBox(
      height: MediaQuery.of(context).size.height - 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// LOGO
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 20),

          /// TITLE
          const Text(
            "BANKMATE",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "MORTGAGE BIDDING SYSTEM",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 60),

          /// LOADER
          const SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation(
                Colors.greenAccent,
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Preparing Your Experience...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),

          const Spacer(),

          /// VERSION
          const Text(
            "Version 1.0.0",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),

          SizedBox(height: 5),

          const Text(
            "© 2026 BankMate",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    ),
  ),
),
            /// VERSION
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "© 2026 BankMate",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}