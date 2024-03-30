import 'dart:io';
import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/screens/Bottom%20nav/bottom_nav.dart';
import 'package:blockchain_upi/screens/Login/login.dart';
import 'package:blockchain_upi/services/createWallet.dart';
import 'package:blockchain_upi/services/image_helper.dart';
import 'package:blockchain_upi/widgets/custom_button.dart';
import 'package:blockchain_upi/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? _image;
  String imageBase64 = '';
  bool loading = false;
  final ImageHelper _imageHelper = ImageHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/auth/register-login.png',
                width: 250,
                height: 250,
              ),
              Text(
                'Get Started',
                style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff252525)),
              ),
              Text(
                'by creating a free account.',
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff252525)),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    final file = await _imageHelper.getImage();
                    if (file != null) {
                      final cropped =
                          await _imageHelper.crop(file, CropStyle.rectangle);
                      setState(() {
                        _image = cropped;
                      });
                    }
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: _image == null
                            ? const AssetImage(
                                'assets/profile/upload_image.png')
                            : FileImage(_image!) as ImageProvider,
                        radius: 60,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/profile/edit_profile.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                  // child: Container(
                  //   height: 40,
                  //   width: 180,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     //color: bg1,
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(
                  //       color: const Color(0xFF755DC1),
                  //       width: 2,
                  //     ),
                  //   ),
                  //   child: _image == null
                  //       ? const Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         'Upload',
                  //         style: TextStyle(
                  //           color: Color(0xFF755DC1),
                  //           fontSize: 18,
                  //           fontFamily: 'Poppins',
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //       SizedBox(width: 10,),
                  //       Icon(
                  //         Icons.upload_rounded,
                  //         size: 28,
                  //         color: Color(0xFF755DC1),
                  //       ),
                  //     ],
                  //   )
                  //       : Image.file(
                  //     _image!,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: usernameController,
                hintText: 'Enter user name',
                width: 320,
                height: 70,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter password',
                width: 320,
                height: 70,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : MyButton(
                      ontap: () async {
                        setState(() {
                          loading = true;
                        });

                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        /*Step 2: Upload to Firebase storage*/
                        //Install firebase_storage
                        //Import the library

                        //Get a reference to storage root
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        //Create a reference for the image to be stored
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        //Handle errors/success
                        try {
                          //Store the file
                          await referenceImageToUpload
                              .putFile(File(_image!.path));
                          //Success: get the download URL
                          imageBase64 =
                              await referenceImageToUpload.getDownloadURL();
                          print("Got Image");

                          print(imageBase64);
                        } catch (error) {
                          //Some error occurre
                          print("FICKE");
                          print(error);
                        }
                        final nme = WalletProvider().generateMnemonic();
                        final pri = await WalletProvider().getPrivateKey(nme);
                        print("ehere");
                        final res = await HttpApiCalls().makeAccount({
                          "pri_key": pri,
                          "name": usernameController.text,
                          "image": imageBase64,
                          "date": DateTime.now().toString(),
                        });

                        print(" Not here here");

                        print(res);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.setString("address", res['address']);
                        await prefs.setString(
                            "private_key", res['private_key']);
                        await prefs.setString("image", imageBase64);
                        await prefs.setString("name", usernameController.text);
                        await prefs.setBool("loginned", true);

                        Map<String, int> initialCategories = {
                          'food expenses': 0,
                          'bills': 0,
                          'finance': 0,
                          'medical': 0,
                          'others': 0,
                        };

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(res['address'])
                            .set(initialCategories);

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBar(),
                          ),
                          (route) => false,
                        );
                      },
                      height: 50,
                      width: double.infinity,
                      title: 'Register',
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
                    'Already a member? ',
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
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
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
