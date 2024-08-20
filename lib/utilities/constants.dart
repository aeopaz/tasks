import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//No se esta utilizando
const kTextFieldDecorationLogin = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintText: 'Email',
  hintStyle: TextStyle(color: Colors.grey),
  labelStyle: TextStyle(color: Colors.black),
);

const kServer = 'http://192.168.18.227:8000/api/mobile';
const kServerWebsockets = 'http://192.168.18.227:8000/api/mobile/ws/auth';

const kEstados = {
  'PE': ['Pendiente', LightColors.kRed],
  'PR': ['En proceso', LightColors.kDarkYellow],
  'FI': ['Finalizada', LightColors.kBlue],
};

const kPrioridad = {
  'A': ['Alto', Icons.priority_high],
  'M': ['Medio', Icons.warning],
  'B': ['Bajo', Icons.low_priority],
};

DateFormat kDateFormat = DateFormat('yyyy-MM-dd');
