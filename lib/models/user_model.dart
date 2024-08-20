import 'dart:convert';

import 'package:bizzytasks_app/helpers/networking.dart';
import 'package:bizzytasks_app/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

class User {
  //Obtener token para iniciar sesión
  Future<dynamic> getToken({context, email, password}) async {
    String deviceName = '';
    if (Platform.isIOS) {
      deviceName = "ios";
    } else if (Platform.isAndroid) {
      deviceName = "android";
    } else {
      deviceName = "mobil";
    }

    Map<String, String> body = {
      'email': email,
      'password': password,
      'device_name': deviceName
    };
    NetworHelper networHelper =
        NetworHelper(url: '/sanctum/token', context: context, body: body);

    var decodeData = await networHelper.postData();

    return decodeData;
  }

//Almacenar el token en el dispositivo
  Future<dynamic> setToken(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic dataUser = data['data'];
    prefs.setString('token', dataUser['token']);
  }

  //Obtener los datos del usuario autenticado
  Future<dynamic> getUser() async {
    NetworHelper networHelper = NetworHelper(url: '/get_user_data');
    var decodeData = await networHelper.getData();
    return decodeData;
  }

  //Cerrar sesión
  Future<dynamic> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    // dynamic info = Provider.of<UserProvider>(context, listen: false).userInfo;
    // await pusher.unsubscribe("my-channel");
  }
}
