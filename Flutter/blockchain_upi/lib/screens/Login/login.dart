import 'package:blockchain_upi/screens/Bottom%20nav/bottom_nav.dart';
import 'package:blockchain_upi/screens/Login/mfa.dart';
import 'package:blockchain_upi/screens/Login/register.dart';
import 'package:blockchain_upi/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/auth/register-login.png',
                width: 250,
                height: 250,
              ),
              Text(
                'Welcome back',
                style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff252525)),
              ),
              Text(
                'Sign in to access the account',
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff252525)),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // CustomTextField(
              //   controller: usernameController,
              //   hintText: 'Enter user name',
              //   width: 320,
              //   height: 70,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // CustomTextField(
              //   controller: passwordController,
              //   hintText: 'Enter password',
              //   width: 320,
              //   height: 70,
              // ),
              const SizedBox(
                height: 80,
              ),
              MyButton(
                ontap: () async {
                  // bool auth = await Authentication.authetication();
                  // print("Authentication: $auth");
                  if (true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(msg: "Error occurred");
                  }
                },
                height: 50,
                width: double.infinity,
                title: 'Login',
                fontSize: 20,
                borderRadius: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New Member? ',
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff252525)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: Text(
                      'Register now',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff6C63FF),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
