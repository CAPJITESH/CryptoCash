import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  SharedPreferences? prefs;
  String address = "";
  String pri_address = "";
  String name = "";

  void getData() async {
    prefs = await SharedPreferences.getInstance();
    address = prefs!.getString("address")!;
    name = prefs!.getString("name")!;
    pri_address = prefs!.getString("private_key")!;
    setState(() {});
  }

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: QrImageView(
                data: address,
                version: QrVersions.auto,
                size: 260.0,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              name,
              style: TextStyle(
                color: purple2,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 90,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              decoration: BoxDecoration(
                color: purple4,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account Address",
                        style: TextStyle(
                          color: purple1,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Text(
                          address,
                          style: TextStyle(
                            color: purple1,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(text: address),
                          );
                          showToast(context,
                              "Account Address Copied Successfully", 3);
                        },
                        child: Icon(
                          Icons.copy_rounded,
                          color: purple1,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: purple1.withOpacity(0.5),
                    height: 1,
                    thickness: 0.4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Private Address",
                        style: TextStyle(
                          color: purple1,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Text(
                          pri_address,
                          style: TextStyle(
                            color: purple1,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(text: pri_address),
                          );
                          showToast(context,
                              "Private Address Copied Successfully", 3);
                        },
                        child: Icon(
                          Icons.copy_rounded,
                          color: purple1,
                          size: 20,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: purple5,
                borderRadius: BorderRadius.circular(10),
              ),
              // height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purple4,
                      minimumSize: const Size(160, 45),
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Share QR",
                          style: TextStyle(
                            color: purple1,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.share_rounded,
                          color: purple1,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purple4,
                      minimumSize: const Size(160, 45),
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Download QR",
                          style: TextStyle(
                            color: purple1,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.download_rounded,
                          color: purple1,
                          size: 25,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
