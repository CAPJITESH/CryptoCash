import 'package:flutter/material.dart';

class TransferTo extends StatefulWidget {
  const TransferTo({super.key});

  @override
  State<TransferTo> createState() => _TransferToState();
}

class _TransferToState extends State<TransferTo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 28,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
