import 'package:blockchain_upi/constants.dart';
import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/models/get_home_data.dart';
import 'package:blockchain_upi/screens/Home/transaction_card_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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

  String? profileImage;
  String? userName;
  String? address;
  bool loading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  SharedPreferences? prefs;

  void getData() async {
    prefs = await SharedPreferences.getInstance();
    profileImage = prefs!.getString("image");
    userName = prefs!.getString('name');
    address = prefs!.getString("address");

    print(address);
    print(userName);
    loading = false;
    setState(() {});
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: HttpApiCalls().getHomeData({'address': address}),
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
                              return TransactionCardHome(
                                data: res.transaction![index],
                                isLast: index == res.transaction!.length - 1,
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
