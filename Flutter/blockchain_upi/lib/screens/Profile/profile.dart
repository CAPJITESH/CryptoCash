
import 'package:blockchain_upi/screens/Profile/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
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
              InkWell(
                onTap: () {},
                child: ProfilePageCards(
                  image: 'assets/profile/kyc.png',
                  title: 'KYC',
                  onTap: () {},
                ),
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
