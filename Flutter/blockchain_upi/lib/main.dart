import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/screens/Bottom%20nav/bottom_nav.dart';
import 'package:blockchain_upi/screens/Login/login.dart';
import 'package:blockchain_upi/screens/Login/mfa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  SharedPreferences? prefs;
  bool? login;
  bool auth = false;
  getData() async {
    prefs = await SharedPreferences.getInstance();
    login = prefs!.getBool("loginned");
    auth = await Authentication.authetication();
    print("Authentication: $auth");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blockchain UPI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: purple2),
        useMaterial3: true,
        textTheme: GoogleFonts.sairaTextTheme(Theme.of(context).textTheme),
      ),
      home: login != null ? const BottomNavBar() : const Login(),
    );
  }
}
