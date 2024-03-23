import 'package:blockchain_upi/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextBox extends StatefulWidget {
  final TextEditingController? controller;
  final String? hinttext;
  final String? Function(String?)? validator;
  bool obscureText;
  final String? label;
  final double width;
  final double height;
  final FocusNode? node;
  final IconData? icon;
  final bool isPassword;
  final bool isNumber;
  final bool readOnly;
  final String? value;
  final VoidCallback? onTap;
  final int maxLines;
  final double? labelFontsize;
  TextBox(
      {Key? key,
      this.controller,
      this.hinttext,
      this.validator,
      this.obscureText = false,
      this.label,
      this.node,
      this.width = 0,
      this.height = 55,
      this.icon,
      this.isPassword = false,
      this.isNumber = false,
      this.readOnly = false,
      this.value,
      this.onTap,
      this.maxLines = 1,
      this.labelFontsize})
      : super(key: key);

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  late bool focused;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    focused = false;
    _focusNode = widget.node ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        focused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != "")
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 2),
            child: Text(
              widget.label!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Container(
          constraints: const BoxConstraints(minHeight: 55),
          width: widget.width == 0 ? double.infinity : widget.width,
          height: widget.height == 55 ? 70 : widget.height,
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            style: TextStyle(color: widget.readOnly ? grey1 : Colors.black),
            readOnly: widget.readOnly,
            initialValue: widget.value,
            onTap: widget.onTap,
            maxLines: widget.maxLines,
            keyboardType:
                widget.isNumber ? TextInputType.number : TextInputType.text,
            maxLength: widget.isNumber ? 10 : null,

            decoration: InputDecoration(
              labelText: widget.hinttext,
              floatingLabelAlignment: FloatingLabelAlignment.start,

              counter: const SizedBox.shrink(),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: grey1, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              // error: SizedBox.shrink(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.readOnly ? grey1 : color1, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),

              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              suffixIcon: widget.isPassword
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          widget.obscureText = !widget.obscureText;
                        });
                      },
                      child: Icon(
                        widget.obscureText
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: focused || !widget.obscureText ? color1 : grey1,
                      ),
                    )
                  : Icon(
                      widget.icon,
                      color: focused ? color1 : grey1,
                    ),
              labelStyle: TextStyle(
                  color: focused && !widget.readOnly ? color1 : grey1,
                  fontSize: widget.labelFontsize),
            ),
            obscureText: widget.obscureText,
            // validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
