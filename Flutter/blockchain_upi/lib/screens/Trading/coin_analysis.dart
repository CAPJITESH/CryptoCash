import 'dart:convert';
import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/screens/Trading/chart_model.dart';
import 'package:blockchain_upi/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SelectCoin extends StatefulWidget {
  var selectItem;
  SelectCoin(
      {super.key,
      required this.name,
      required this.symbol,
      required this.imageUrl,
      required this.price,
      required this.change,
      required this.changePercentage,
      required this.id,
      required this.high_24h,
      required this.low_24h,
      this.selectItem});

  String name;
  String symbol;
  String imageUrl;
  double price;
  double change;
  double changePercentage;
  String id;
  String high_24h;
  String low_24h;

  // SelectCoin({this.selectItem});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  TrackballBehavior trackballBehavior =
      TrackballBehavior(enable: true, shouldAlwaysShow: true);
  bool loading = false;
  Future<void> getChart() async {
    print("******************Inside get chart************************");
    try {
      String url =
          'https://api.coingecko.com/api/v3/coins/${widget.id}/ohlc?vs_currency=usd&days=$days';

      setState(() {
        isRefresh = true;
      });

      var response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });
      print("Response: ");
      print(response);

      setState(() {
        isRefresh = false;
      });
      if (response.statusCode == 200) {
        Iterable x = json.decode(response.body);
        List<ChartModel> modelList =
            x.map((e) => ChartModel.fromJson(e)).toList();
        setState(() {
          itemChart = modelList;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    print("Init state");
    super.initState();
    getChart();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: myHeight * 0.08,
                            child: Image.network(widget.imageUrl)),
                        SizedBox(
                          width: myWidth * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              widget.symbol,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${widget.price}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: myHeight * 0.01,
                        ),
                        Text(
                          '${widget.changePercentage}%',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: widget.changePercentage >= 0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: myWidth * 0.03, vertical: myHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Low',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$${widget.low_24h}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'High',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$${widget.high_24h}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Vol',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$${widget.change}M',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.015,
                  ),
                  SizedBox(
                    height: myHeight * 0.4,
                    width: myWidth,
                    // color: Colors.amber,
                    child: isRefresh == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffFBC700),
                            ),
                          )
                        : itemChart == null
                            ? Padding(
                                padding: EdgeInsets.all(myHeight * 0.06),
                                child: const Center(
                                  child: Text(
                                    'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            : SfCartesianChart(
                                enableAxisAnimation: true,
                                trackballBehavior: trackballBehavior,
                                zoomPanBehavior: ZoomPanBehavior(
                                    enablePinching: true, zoomMode: ZoomMode.x),
                                series: <CandleSeries>[
                                  CandleSeries<ChartModel, int>(
                                      enableSolidCandles: true,
                                      enableTooltip: true,
                                      bullColor: Colors.green,
                                      bearColor: Colors.red,
                                      dataSource: itemChart!,
                                      xValueMapper: (ChartModel sales, _) =>
                                          sales.time,
                                      lowValueMapper: (ChartModel sales, _) =>
                                          sales.low,
                                      highValueMapper: (ChartModel sales, _) =>
                                          sales.high,
                                      openValueMapper: (ChartModel sales, _) =>
                                          sales.open,
                                      closeValueMapper: (ChartModel sales, _) =>
                                          sales.close,
                                      animationDuration: 55)
                                ],
                              ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  // Center(
                  //   child: Container(
                  //     height: myHeight * 0.03,
                  //     child: ListView.builder(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: text.length,
                  //       itemBuilder: (context, index) {
                  //         return Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: myWidth * 0.02),
                  //           child: GestureDetector(
                  //             onTap: () {
                  //               setState(() {
                  //                 textBool = [
                  //                   false,
                  //                   false,
                  //                   false,
                  //                   false,
                  //                   false,
                  //                   false
                  //                 ];
                  //                 textBool[index] = true;
                  //               });
                  //               setDays(text[index]);
                  //             },
                  //             child: Container(
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal: myWidth * 0.03,
                  //                   vertical: myHeight * 0.005),
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(5),
                  //                 color: textBool[index] == true
                  //                     ? Color(0xffFBC700).withOpacity(0.3)
                  //                     : Colors.transparent,
                  //               ),
                  //               child: Text(
                  //                 text[index],
                  //                 style: TextStyle(fontSize: 18),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: myHeight * 0.1,
                  // ),

                  SizedBox(
                    height: myHeight * 0.1,
                    width: myWidth,
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: myWidth * 0.05,
                            ),
                            loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      final res = await HttpApiCalls().buyCoin({
                                        "acc1":
                                            prefs.getString("address") ?? "",
                                        "p1": prefs.getString("private_key") ??
                                            "",
                                        "tx_name": "${widget.name} bought",
                                        "price": "${widget.price}",
                                        "date": DateTime.now().toString(),
                                      });
                                      print(res);
                                      showToast(context, res['message'], 5);
                                      Navigator.of(context).pop();
                                    },
                                    child: Expanded(
                                      flex: 5,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: myHeight * 0.015),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color(0xff270685)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: myHeight * 0.03,
                                            ),
                                            const SizedBox(
                                              width: 1,
                                            ),
                                            const Text(
                                              'Add to portfolio',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: myWidth * 0.05,
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: myHeight * 0.012),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey.withOpacity(0.2)),
                                child: Image.asset(
                                  'assets/3.1.jpeg',
                                  height: myHeight * 0.03,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: myWidth * 0.05,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: myWidth * 0.06),
                        child: const Text(
                          'News',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: myWidth * 0.06,
                            vertical: myHeight * 0.01),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Crypto Donations Surge for Ukraine Relief Efforts",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  'Millions of dollars in cryptocurrency donations are pouring into Ukraine to support humanitarian efforts in the wake of the ongoing conflict. According to a report by [source], donations in Bitcoin, Ethereum, and other cryptocurrencies have surpassed \$100 million since the crisis began.This trend highlights the unique advantages of cryptocurrency for international aid.Donations are processed quickly and securely, bypassing traditional financial systems that may face delays or restrictions.dditionally, the transparent nature of blockchain technology allows for greater accountability and ensures funds reach their intended recipients.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                ),
                              ],
                            )),
                            // Container(
                            //   width: myWidth * 0.25,
                            //   child: CircleAvatar(
                            //     radius: myHeight * 0.04,
                            //     backgroundImage:
                            //         AssetImage('assets/image/11.PNG'),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              )),
            ],
          ),
        ),
      ),
    ));
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [false, false, true, false, false, false];

  int days = 30;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;

  bool isRefresh = true;
}
