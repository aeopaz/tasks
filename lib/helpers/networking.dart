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
    if (response.statusCode <= 204) {
      String data = response.body;
      showServerResponse(response);
      return jsonDecode(data);
    } else {
      showServerResponse(response);
    }
  }

  Future getData() async {
    dynamic headers = await getHeaders();
    http.Response response =
        await http.get(Uri.parse(kServer + url), headers: headers);
    if (response.statusCode <= 204) {
      String data = response.body;
      showServerResponse(response);
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
    dynamic data = jsonDecode(response.body);
    int nivel = data['nivel'] == null ? 2 : data['nivel'];
    if (nivel < 3) {
      List<Widget> message = [];
      int statusCode = response.statusCode;
      String titleMessage = '';

      if (statusCode >= 400) {
        titleMessage = "Error";
        if (statusCode == 422) {
          data['errors'].forEach(
            (key, value) => message.add(
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      '\u2022 ' + key + ': ' + value[0],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          message.add(Text(data['message']));
        }
      } else {
        titleMessage = 'OK';
        message.add(Text(data['message']));
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog(
              titleMessage,
              Column(
                children: message,
              ));
        },
      );
    }
  }
}
