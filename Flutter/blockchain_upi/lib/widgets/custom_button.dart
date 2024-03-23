import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  //final Widget child;
  final void Function()? ontap;
  final double height;
  final double width;
  final String title;
  final double fontSize;
  final double borderRadius;

  const MyButton({
    super.key,
    required this.ontap,
    required this.height,
    required this.width,
    required this.title,
    required this.fontSize,
    this.borderRadius = 100,
    //required this.child
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: GoogleFonts.montserrat(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
