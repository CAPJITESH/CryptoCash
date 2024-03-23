import 'dart:io';
import 'package:blockchain_upi/screens/Payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  String code = "";
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final ImagePicker picker = ImagePicker();

  Future<String?> loadimage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          _buildQrView(context),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: Card(
                color: Colors.white.withOpacity(0.3),
                child: IconButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      controller!.pauseCamera();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 28,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.white.withOpacity(0.3),
                      child: IconButton(
                          onPressed: () {
                            controller!.toggleFlash();
                          },
                          icon: Image.asset(
                            "assets/flashlight1.png",
                            height: 20,
                            color: Colors.white,
                          )),
                    ),
                    Card(
                      color: Colors.white.withOpacity(0.3),
                      child: IconButton(
                        onPressed: () async {
                          var imgpath = await loadimage();
                          if (imgpath != null) {
                            var result = await Scan.parse(imgpath);
                            print(" $result");
                          }
                        },
                        icon: Image.asset(
                          "assets/file.png",
                          height: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white.withOpacity(0.3),
                      child: IconButton(
                        onPressed: () async {
                          await controller!.flipCamera();
                        },
                        icon: Image.asset(
                          "assets/flipcamera.png",
                          height: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      print("Fuck");

      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        code = scanData.code!;
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PaymentPage(
              receiverAddress: scanData.code!,
            ),
          ),
        );

        controller.pauseCamera();
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
