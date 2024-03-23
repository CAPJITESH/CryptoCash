import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/widgets/textbox.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // final TextEditingController _acc1 = TextEditingController();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Generate QR"),
  //     ),
  //     body: Center(
  //       child: SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             children: [
  //               if (_acc1.text.isNotEmpty)
  //                 QrImageView(
  //                   data: _acc1.text,
  //                   version: QrVersions.auto,
  //                   size: 200.0,
  //                 ),
  //               const SizedBox(
  //                 height: 30,
  //               ),
  //               TextBox(
  //                 controller: _acc1,
  //                 hinttext: "Enter Account id",
  //                 label: "",
  //                 obscureText: false,
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   setState(() {});
  //                 },
  //                 child: const Text('Generate QR'),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  final TextEditingController _acc1 = TextEditingController();
  final TextEditingController _acc2 = TextEditingController();
  final TextEditingController _p1 = TextEditingController();
  final TextEditingController _eth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: _acc1,
                hinttext: "Account 1",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: _p1,
                hinttext: "Private key 1",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: _acc2,
                hinttext: "Account 2",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: _eth,
                hinttext: "Ether",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final d = await HttpApiCalls().sendEther({
                    'acc1': _acc1.text,
                    "acc2": _acc2.text,
                    "p1": _p1.text,
                    'eth': _eth.text,
                  });
                },
                child: const Text("Transfer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
