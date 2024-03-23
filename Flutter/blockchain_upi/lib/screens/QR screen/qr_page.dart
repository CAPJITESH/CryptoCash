import 'package:blockchain_upi/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  String res = "";

  Future<void> scanQR() async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        color3.toString(), "Cancel", true, ScanMode.QR);

    if (!mounted) {
      return;
    } else {
      setState(() {
        res = qrCode.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate QR"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (res != "")
                  Text(
                    res,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    scanQR();
                  },
                  child: const Text('Scan QR'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
