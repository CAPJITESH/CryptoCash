import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/models/get_home_data.dart';
import 'package:blockchain_upi/screens/Home/transaction_card_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {
  // String? imageGetter(String username) {
  //   for (int i = 0; i < widget.tran.length; i++) {
  //     if (widget.tran[i].to == username) {
  //       return widget.tran[i].receiverImage;
  //     } else if (widget.tran[i].from == username) {
  //       return widget.tran[i].senderImage;
  //     }
  //   }
  //   return '';
  // }

  Map<String, List<Transaction>> data = {};

  // getData() {
  //   try {
  //     print(widget.tran.length);
  //     print(widget.uniqData.length);
  //     for (int i = 0; i < widget.uniqData.length; i++) {
  //       if (data[widget.uniqData[i]] == null) {
  //         data[widget.uniqData[i]] == [];
  //       }
  //       for (int i = 0; i < widget.tran.length; i++) {
  //         for (int j = 0; j < widget.uniqData.length; i++) {
  //           if (widget.tran[i].to == widget.uniqData[j] &&
  //               data[widget.uniqData[i]] != null) {
  //             data[widget.uniqData[i]].add(widget.tran[i]);
  //           }
  //           if (widget.tran[i].from == widget.uniqData[j]) {
  //             data[widget.uniqData[i]]!.add(widget.tran[i]);
  //           }
  //         }
  //       }
  //     }
  //     print(data);
  //   } catch (e) {
  //     print("hereefe$e");
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  Stream homeDataStream() async* {
    while (true) {
      print("ahahahah");

      print("above");
      yield await HttpApiCalls().getTransactions();

      await Future.delayed(const Duration(seconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: purple2,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 28,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Transactions',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: homeDataStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final res = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: res!.transaction!.length,
                      itemBuilder: (context, index) {
                        String date = "";

                        DateTime parsedDate =
                            DateTime.parse(res.transaction![index].date ?? "");

                        date = DateFormat('MMMM d H:mm').format(parsedDate);

                        return Container(
                          margin: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          height: 100,
                          decoration: BoxDecoration(
                            color: bg1,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From: ${res.transaction![index].from}",
                                style: TextStyle(
                                  color: purple1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "To: ${res.transaction![index].to}",
                                style: TextStyle(
                                  color: purple1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Amount: ${res.transaction![index].amt}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Date: $date",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print("WTFFFFFFF");
            print(snapshot.error);
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
