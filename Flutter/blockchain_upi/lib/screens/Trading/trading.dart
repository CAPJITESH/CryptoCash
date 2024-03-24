import 'dart:async';
import 'dart:convert';

import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/screens/Trading/coin_card.dart';
import 'package:blockchain_upi/screens/Trading/coin_model.dart';
import 'package:flutter/material.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  _TradePageState createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  bool loader = false;
  List<Coin> coinList = [];
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    var response = await HttpApiCalls().getBitcoin();
    final List<Map<String, dynamic>> res =
        List<Map<String, dynamic>>.from(json.decode(response));
    // print(res);

    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        //print('Id: ${res[i]['id']}, Symbol: ${res[i]['symbol']}');
        coinList.add(Coin(
          name: res[i]['name'],
          symbol: res[i]['symbol'],
          imageUrl: res[i]['image'],
          price: res[i]['current_price'],
          change: res[i]['price_change_24h'],
          changePercentage: res[i]['price_change_percentage_24h'],
          id: res[i]["id"],
          high_24h: res[i]["high_24h"].toString(),
          low_24h: res[i]["low_24h"].toString(),
        ));
      }
      //setState(() {});
      setState(() {
        coinList;
      });
    }
    return coinList;
  }

  @override
  void initState() {
    fetchCoin();
    // Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          'Trading',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: coinList.length,
        itemBuilder: (context, index) {
          return CoinCard(
            name: coinList[index].name,
            symbol: coinList[index].symbol,
            imageUrl: coinList[index].imageUrl,
            price: coinList[index].price.toDouble(),
            change: coinList[index].change.toDouble(),
            changePercentage: coinList[index].changePercentage.toDouble(),
            id: coinList[index].id,
            low_24h: coinList[index].low_24h,
            high_24h: coinList[index].high_24h,
          );
        },
      ),
    );
  }
}
