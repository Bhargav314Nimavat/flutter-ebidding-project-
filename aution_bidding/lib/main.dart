import 'package:flutter/material.dart';
import 'features/home/presentation/widgets/fragment_placeholder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FragmentPlaceholder(),
    );
  }
}