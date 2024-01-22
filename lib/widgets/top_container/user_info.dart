import 'package:bizzytasks_app/models/user_model.dart';
import 'package:bizzytasks_app/screens/login_page.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

User user = User();

//Información del usuario
Column userInfo(context, data) {
  dynamic info = data['data']['user'];
  List<String> nombre = info['ca100nombre'].split(' ');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        child: Text(
          nombre[0] + ' ' + nombre[1],
          maxLines: 2,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 22.0,
            color: LightColors.kDarkBlue,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Container(
        child: Text(
          info['ca100rol'],
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black45,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      //Salir
      GestureDetector(
        onTap: () async {
          await user.logout();
          Navigator.pushReplacementNamed(context, LoginPage.id);
        },
        child: Icon(
          Icons.logout,
          size: 20.0,
          color: Colors.black,
        ),
      )
    ],
  );
}
