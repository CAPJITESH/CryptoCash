import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final double height;
  final Color hintColor;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? type;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final VoidCallback? onFocusChanged;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.width = double.infinity,
    this.height = 50.0,
    this.hintColor = const Color.fromRGBO(0, 0, 0, 0.4),
    this.minLines,
    this.maxLength,
    this.type,
    this.inputFormatters,
    this.focusNode,
    this.onFocusChanged,
    this.maxLines,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Focus(
        focusNode: focusNode,
        onFocusChange: (hasFocus) {
          if (onFocusChanged != null) {
            onFocusChanged!();
          }
        },
        child: TextField(
          onChanged: onChanged,
          maxLength: maxLength,
          // maxLines: maxLines,
          // minLines: minLines,
          keyboardType: type,
          inputFormatters: inputFormatters,
          controller: controller,
          cursorColor: const Color.fromRGBO(0, 0, 0, 1),
          decoration: InputDecoration(
            counterText: " ",
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
              color: hintColor,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(54, 54, 54, 0.8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
