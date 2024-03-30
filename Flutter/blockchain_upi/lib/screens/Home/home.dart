import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/models/get_home_data.dart';
import 'package:blockchain_upi/screens/History/history.dart';
import 'package:blockchain_upi/screens/Chatbot/mybot.dart';
import 'package:blockchain_upi/screens/Home/transaction_card_home.dart';
import 'package:blockchain_upi/screens/Transactions/transactions.dart';
import 'package:blockchain_upi/screens/courses/coursescategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? profileImage;
  String? userName;
  String? address;

  @override
  void initState() {
    getData();
    super.initState();
  }

  SharedPreferences? prefs;

  void getData() async {
    prefs = await SharedPreferences.getInstance();
    profileImage = prefs!.getString("image");
    userName = prefs!.getString('name');
    address = prefs!.getString("address");

    print(address);
    print(userName);
    setState(() {});
  }

  Stream homeDataStream() async* {
    while (true) {
      yield await HttpApiCalls().getHomeData({'address': address});

      await Future.delayed(const Duration(seconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<dynamic>(
          stream: homeDataStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              HomeModel res = snapshot.data;
              int length =
                  res.transaction!.length < 3 ? res.transaction!.length : 3;

              // Map<String, dynamic> transactions = {};

              // for (int i = 0; i < res.transaction!.length; i++) {
              //   if (transactions[res.transaction![i].to!] == null) {
              //     transactions[res.transaction![i].to!] = {
              //       if (res.transaction![i].to == userName)
              //         "name": res.transaction![i].to,
              //       if (res.transaction![i].from == userName)
              //         "name": res.transaction![i].from,
              //       if (res.transaction![i].from == userName)
              //         "name": res.transaction![i].from,
              //       if (res.transaction![i].from == userName)
              //         "name": res.transaction![i].from,
              //     };
              //   }
              // }
              // print(res.toJson());

              // Set<String> setData = {};

              // for (var t in res.transaction!) {
              //   if (t.from != userName) {
              //     setData.add(t.from!);
              //   }
              //   if (t.to != userName) {
              //     setData.add(t.to!);
              //   }
              // }
              // final data = setData.toList();
              // print(data);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 343,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: purple1,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: profileImage != null
                                          ? NetworkImage(profileImage!)
                                          : const AssetImage(
                                              "assets/profile.png",
                                            ) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Hello",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      userName ?? "Guest",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TransactionPage(),
                                      ),
                                    );
                                  },
                                  padding: const EdgeInsets.all(0),
                                  icon: const Icon(
                                    Icons.history,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 190,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    const Color(0xFF5033A4),
                                    const Color(0xFF331098).withOpacity(0.65),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Main Balance",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${res.balance!.length >= 8 ? res.balance!.substring(0, 8) : res.balance!} ETH",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 32,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.upload_rounded,
                                              size: 26,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Top up",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 1,
                                        color: purple4,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.download_rounded,
                                              size: 26,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Withdraw",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 1,
                                        color: purple4,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.attach_money_rounded,
                                              size: 26,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Transfer",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        children: [
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Latest Transactions",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const HistoryPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                ),
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                    color: black2,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          for (int i = 0; i < length; i++)
                            TransactionCardHome(
                              data: res.transaction![i],
                              isLast: length - 1 == i,
                            ),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                              "Analysis",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(address)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final categories = snapshot.data!.data()
                                    as Map<String, dynamic>;

                                if (categories.values
                                    .every((value) => value == 0)) {
                                  return const SizedBox.shrink();
                                }

                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 165,
                                          width: 165,
                                          child: PieChart(
                                            PieChartData(
                                              centerSpaceRadius: 45,
                                              sections: [
                                                PieChartSectionData(
                                                  value: categories['bills']
                                                      .toDouble(),
                                                  title: "Bills",
                                                  color: red2,
                                                  showTitle: true,
                                                  titleStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                PieChartSectionData(
                                                  value: categories[
                                                          'food expenses']
                                                      .toDouble(),
                                                  title: "Food",
                                                  color: yellow1,
                                                  showTitle: true,
                                                  titleStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                PieChartSectionData(
                                                  value: categories['medical']
                                                      .toDouble(),
                                                  title: "Medical Expenses",
                                                  showTitle: true,
                                                  color: voilet1,
                                                  titleStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                PieChartSectionData(
                                                  value: categories['finance']
                                                      .toDouble(),
                                                  title: "Finance",
                                                  color: green2,
                                                  showTitle: true,
                                                  titleStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                PieChartSectionData(
                                                  value: categories['others']
                                                      .toDouble(),
                                                  title: "Others",
                                                  color: purple2,
                                                  showTitle: true,
                                                  titleStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  color: red2,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text(
                                                  "Bills",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  color: yellow1,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text(
                                                  "Food",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  color: voilet1,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text(
                                                  "Medical Expenses",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  color: green2,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text(
                                                  "Finance",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  color: purple2,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text(
                                                  "Others",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                print("WTFFFFFFF");
                                print(snapshot.error);
                                return const Center(
                                  child: Text('No Internet Connection'),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (context) => const Chatbot(),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     height: 60,
                    //     margin: const EdgeInsets.only(left: 20, right: 20),
                    //     padding: const EdgeInsets.only(
                    //       left: 15,
                    //       right: 15,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       color: purple5,
                    //     ),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Container(
                    //           height: 40,
                    //           width: 50,
                    //           decoration: BoxDecoration(
                    //             color: bg1,
                    //             borderRadius: BorderRadius.circular(7),
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: const Icon(
                    //             Icons.chat_bubble_outline_rounded,
                    //             color: Colors.blue,
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         const Text(
                    //           "Accounts",
                    //           style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //         const Spacer(),
                    //         const Icon(
                    //           Icons.chevron_right_outlined,
                    //           color: Colors.black,
                    //           size: 25,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 25, right: 25),
                    //   child: Divider(
                    //     color: Colors.grey,
                    //     thickness: 0.5,
                    //     height: 1,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Chatbot(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: purple5,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                color: bg1,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Chat with AI",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.chevron_right_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CoursesCategories(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: purple5,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                color: bg1,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.my_library_books,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Courses",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.chevron_right_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print("WTFFFFFFF");
              print(snapshot.error);
              return const Center(
                child: Text('No Internet Connection'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
