import 'package:blockchain_upi/constants.dart';

import 'package:blockchain_upi/screens/Bottom%20nav/bottom_nav_item.dart';
import 'package:blockchain_upi/screens/Community/community_home.dart';
import 'package:blockchain_upi/screens/Create%20account/create_account.dart';
import 'package:blockchain_upi/screens/Home/home.dart';
import 'package:blockchain_upi/screens/Profile/profile.dart';
import 'package:blockchain_upi/screens/QR%20Page/qr_page.dart';
import 'package:blockchain_upi/screens/Scanner/scanner.dart';
import 'package:blockchain_upi/screens/Trading/trading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:toastification/toastification.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool keyboard = false;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _pageIndex = 0;

  @override
  void initState() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        keyboard = visible;
      });
    });

    super.initState();
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      if (_pageController.page == 0) {
        currentBackPressTime = now;
        toastification.show(
          context: context,
          title: 'Tap on back again to close',
          alignment: const Alignment(0.5, 0.9),
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 2),
        );
      } else {
        _setPage(0);
      }

      return Future.value(false);
    }
    return Future.value(true);
  }

  bool actionIcon = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        // drawer: const DrawerWidget(),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: keyboard || _pageIndex == 2
            ? const SizedBox()
            : SpeedDial(
                buttonSize: const Size(60, 60),
                backgroundColor: purple2,
                overlayOpacity: 0,
                spacing: 15,
                // spaceBetweenChildren: 15,
                onOpen: () {
                  setState(() {
                    actionIcon = true;
                  });
                },
                onClose: () {
                  setState(() {
                    actionIcon = false;
                  });
                },
                children: [
                  SpeedDialChild(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelShadow: [],
                    elevation: 0,
                    backgroundColor: green3,
                    labelBackgroundColor: green4,
                    label: "Scan QR",
                    labelStyle: TextStyle(
                      color: green2,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const QRScanner(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SpeedDialChild(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelShadow: [],
                    elevation: 0,
                    backgroundColor: blue1,
                    labelBackgroundColor: blue2,
                    label: "Show QR",
                    labelStyle: TextStyle(
                      color: blue1,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const QRPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.qr_code_2_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
                child: Icon(
                  actionIcon ? Icons.close_rounded : Icons.qr_code_2_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
        // : FloatingActionButton(
        //     backgroundColor: purple2,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(100),
        //     ),
        //     onPressed: () => _setPage(2),
        //     child: const Icon(
        //       Icons.qr_code_2_rounded,
        //       color: Colors.white,
        //       size: 28,
        //     ),
        //   ),
        bottomNavigationBar: _pageIndex != 2
            ? BottomAppBar(
                height: 60,
                color: bg1,
                padding: EdgeInsets.zero,
                notchMargin: 8,
                shadowColor: black2,
                clipBehavior: Clip.antiAlias,
                shape: const CircularNotchedRectangle(),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: grey1,
                    //     spreadRadius: 10,
                    //     blurRadius: 12,
                    //     // offset: const Offset(0, 1),
                    //   ),
                    // ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BottomNavItem(
                        name: "Home",
                        iconData: Icons.home_rounded,
                        isSelected: _pageIndex == 0,
                        onTap: () => _setPage(0),
                      ),
                      BottomNavItem(
                        name: "Community",
                        iconData: CupertinoIcons.person_2_fill,
                        isSelected: _pageIndex == 1,
                        onTap: () => _setPage(1),
                      ),
                      const Expanded(child: SizedBox()),
                      BottomNavItem(
                        name: "Trade",
                        iconData: Icons.query_stats_rounded,
                        isSelected: _pageIndex == 3,
                        onTap: () => _setPage(3),
                      ),
                      BottomNavItem(
                        name: "Profile",
                        iconData: Icons.person,
                        isSelected: _pageIndex == 4,
                        onTap: () => _setPage(4),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            HomePage(),
            CommunityHome(),
            CreateAccount(),
            TradePage(),
            Profile()
            //CreateAccount(),
          ],
        ),
      ),
    );
  }
}
