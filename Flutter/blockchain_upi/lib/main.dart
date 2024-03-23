import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/screens/Bottom%20nav/bottom_nav.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blockchain UPI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: color1),
        useMaterial3: true,
      ),
      home: const BottomNavBar(),
    );
  }
}
