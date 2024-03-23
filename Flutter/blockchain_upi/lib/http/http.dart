import 'dart:convert';
import 'package:blockchain_upi/constants.dart';
import 'package:http/http.dart' as http;

class HttpApiCalls {
  Future<Map<String, dynamic>> sendEther(Map<String, dynamic> data) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$apiUrl/transaction'));
    request.fields.addAll({
      "acc1": data['acc1'],
      'acc2': data['acc2'],
      "p1": data['p1'],
      "eth": data['eth'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print("hete");
      print(responsedata.body);
      return json.decode(responsedata.body) as Map<String, dynamic>;
    } else {
      print("Fuck");
      print(response.reasonPhrase);
      return {};
    }
  }
}
