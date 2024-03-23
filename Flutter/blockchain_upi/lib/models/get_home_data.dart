import 'dart:convert';

HomeModel HomeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String HomeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String? balance;
  List<Transaction>? transaction;
  String? username;

  HomeModel({this.balance, this.transaction, this.username});

  HomeModel.fromJson(Map<String, dynamic> json) {
    balance = json["balance"];
    transaction = json["transaction"] == null
        ? null
        : (json["transaction"] as List)
            .map((e) => Transaction.fromJson(e))
            .toList();
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["balance"] = balance;
    if (transaction != null) {
      data["transaction"] = transaction?.map((e) => e.toJson()).toList();
    }
    data["username"] = username;
    return data;
  }
}

class Transaction {
  String? amt;
  String? date;
  String? from;
  bool? myself;
  String? name;
  String? receiverImage;
  String? senderImage;
  String? to;

  Transaction(
      {this.amt,
      this.date,
      this.from,
      this.myself,
      this.name,
      this.receiverImage,
      this.senderImage,
      this.to});

  Transaction.fromJson(Map<String, dynamic> json) {
    amt = json["amt"];
    date = json["date"];
    from = json["from"];
    myself = json["myself"];
    name = json["name"];
    receiverImage = json["receiver_image"];
    senderImage = json["sender_image"];
    to = json["to"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["amt"] = amt;
    data["date"] = date;
    data["from"] = from;
    data["myself"] = myself;
    data["name"] = name;
    data["receiver_image"] = receiverImage;
    data["sender_image"] = senderImage;
    data["to"] = to;
    return data;
  }
}
