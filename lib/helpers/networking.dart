import 'package:bizzytasks_app/widgets/my_alert_dialog.dart';
import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NetworHelper {
  NetworHelper({this.url, this.context, this.body});
  final url;
  final context;
  final body;

  Future postData() async {
    dynamic headers = await getHeaders();
    http.Response response = await http.post(Uri.parse(kServer + url),
        body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      showServerResponse(response);
    }
  }

  Future getData() async {
    dynamic headers = await getHeaders();
    http.Response response =
        await http.get(Uri.parse(kServer + url), headers: headers);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      showServerResponse(response);
    }
  }

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString('token');
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    return headers;
  }

  showServerResponse(response) {
    String data = response.body;
    String message = '';

    if (response.statusCode == 422) {
      jsonDecode(data)['errors'].forEach(
          (key, value) => message = '$message $key: ' + value[0] + '\n');
    } else {
      message = jsonDecode(data)['message'];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDialog('Error', Text(message));
      },
    );
  }
}
