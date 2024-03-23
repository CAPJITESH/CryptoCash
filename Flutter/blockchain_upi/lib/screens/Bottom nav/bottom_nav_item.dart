import 'package:blockchain_upi/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData? iconData;
  final VoidCallback? onTap;
  final bool? isSelected;
  final String name;
  const BottomNavItem(
      {super.key,
      @required this.iconData,
      this.onTap,
      this.isSelected = false,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        padding: EdgeInsets.zero,
        splashColor: Colors.white,
        color: Colors.white,
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: isSelected! ? color1 : Colors.black,
            ),
            Text(
              name,
              style: TextStyle(
                  color: isSelected! ? color1 : Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        onPressed: onTap!,
      ),
    );
  }
}
