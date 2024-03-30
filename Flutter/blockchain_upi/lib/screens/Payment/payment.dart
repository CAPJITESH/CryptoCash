import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/screens/Login/mfa.dart';
import 'package:blockchain_upi/widgets/textbox.dart';
import 'package:blockchain_upi/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPage extends StatefulWidget {
  final String receiverAddress;
  const PaymentPage({super.key, required this.receiverAddress});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _ethController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  bool loading = false;

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
        title: Text(
          "Transaction",
          style: TextStyle(
            color: purple1,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future:
            HttpApiCalls().getUserDetails({"address": widget.receiverAddress}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            // print("fsfsfsfsfsfsfsfsf");
            // print(data);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Transfer to",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: bg1,
                            image: DecorationImage(
                              image: NetworkImage(data!['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['username'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.receiverAddress,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await Clipboard.setData(
                                        ClipboardData(
                                            text: widget.receiverAddress),
                                      );
                                      showToast(
                                          context,
                                          "Account Address Copied Successfully",
                                          3);
                                    },
                                    child: Icon(
                                      Icons.copy_rounded,
                                      color: black2,
                                      size: 23,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextBox(
                      controller: _ethController,
                      hinttext: "Enter Ether",
                      label: "",
                      isNumber: true,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextBox(
                      controller: _reasonController,
                      hinttext: "Reason For Transaction",
                      label: "",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              bool auth = await Authentication.authetication();
                              print("Authentication: $auth");

                              if (auth) {
                                setState(() {
                                  loading = true;
                                });
                                if (_reasonController.text.isEmpty) {
                                  _reasonController.text = "other";
                                }
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                final res = await HttpApiCalls().transaction({
                                  "acc1": prefs.getString("address") ?? "",
                                  "p1": prefs.getString("private_key") ?? "",
                                  'acc2': widget.receiverAddress,
                                  "tx_name": _reasonController.text,
                                  "eth": _ethController.text,
                                  "date": DateTime.now().toString(),
                                });
                                showToast(context, res['message'], 4);
                                Navigator.of(context).pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: purple1,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Transfer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print("WTFFFFFFF");
            return const Center(
              child: Text('No Internet Connection'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
