import 'package:flutter/material.dart';

class Coin {
  Coin({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
    required this.id,
    required this.high_24h,
    required this.low_24h,
  });

  String name;
  String symbol;
  String imageUrl;
  num price;
  num change;
  num changePercentage;
  String id;
  String high_24h;
  String low_24h;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      imageUrl: json['image'],
      price: json['current_price'],
      change: json['price_change_24h'],
      changePercentage: json['price_change_percentage_24h'],
      id: json["id"],
      high_24h: json["high_24h"].toString(),
      low_24h: json["low_24h"].toString(),
    );
  }
}

List<Coin> coinList = [];
