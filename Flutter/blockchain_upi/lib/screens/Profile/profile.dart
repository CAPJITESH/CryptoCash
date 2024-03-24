import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/screens/Profile/profile_card.dart';
import 'package:blockchain_upi/widgets/textbox.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController adhaarController = TextEditingController();
  bool verified = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  String? username;
  String? profile_photo;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("name");
    profile_photo = prefs.getString("image");

    setState(() {});
  }

  void _showKYCBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              const Text(
                "Enter Details for KYC",
                style: TextStyle(
                  color: Color(0xFF270685),
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: adhaarController,
                hinttext: "Adhaar Card Number",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final res = await HttpApiCalls()
                      .aadhaarVerification(adhaarController.text);
                  print("Result from API: $res");
                  verified = res;
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF270685),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF5732BF),
        title: Center(
          child: Text(
            'Profile',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        backgroundImage: NetworkImage(
                          profile_photo ??
                              "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_640.png",
                        ),
                      )
                      // if (SharedPreferencesHelper.getUserProfilePic() == "")
                      //   const CircleAvatar(
                      //     backgroundColor: Colors.transparent,
                      //     radius: 50,
                      //     backgroundImage: NetworkImage(
                      //         "https://raw.githubusercontent.com/Mitra-Fintech/cdn-mitraapp-in/main/images/mitra-profile-image.png"),
                      //   )
                      // else
                      //   CircleAvatar(
                      //     backgroundColor: Colors.transparent,
                      //     backgroundImage: NetworkImage(
                      //         SharedPreferencesHelper.getUserProfilePic()),
                      //     radius: 50,
                      //   ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username ?? "Anonymous",
                        //SharedPreferencesHelper.getUserName(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AbsorbPointer(
                absorbing: verified,
                child: InkWell(
                    onTap: _showKYCBottomSheet,
                    child: SizedBox(
                      height: 60,
                      child: Card(
                        color: bg1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/profile/kyc.png",
                                    height: 20,
                                    width: 20,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "KYC",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              if (verified)
                                Image.asset("assets/profile/verified.png",
                                    width: 28, height: 28, color: Colors.green),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              ProfilePageCards(
                  image: 'assets/profile/rate.png',
                  title: 'Rate our app',
                  onTap: () {}),
              const SizedBox(
                height: 10,
              ),
              ProfilePageCards(
                  image: 'assets/profile/help_and_support.png',
                  title: 'Help',
                  onTap: () {}),
              const SizedBox(
                height: 10,
              ),
              ProfilePageCards(
                  image: 'assets/profile/privacy_policy.png',
                  title: 'Privacy Policy',
                  onTap: () {}),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content:
                            const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              // SharedPreferencesHelper.clearShareCache();
                              // SharedPreferencesHelper.setIsLoggedIn(
                              //     status: false);
                              // _sharedPreferences.setBool(
                              //     'isFirstTime', false);
                              // Fluttertoast.showToast(
                              //     msg: "Logout Successful");
                              // Get.offAll(() => const LoginSignupScreen());
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ProfilePageCards(
                  image: 'assets/profile/logout.png',
                  title: 'Log Out',
                  onTap: () {},
                ),
              ),
              const SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
