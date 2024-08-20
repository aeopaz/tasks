import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Instancia del package
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Este es el método que inicializa el objeto de notificaciones
Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Este es el método que muestra la notificación
Future<void> showNotificacion({dataNotificacion}) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  try {
    if (dataNotificacion.data.length > 0) {
      print(jsonDecode(dataNotificacion.data));
      dynamic dataJson = jsonDecode(dataNotificacion.data);
      String title = dataJson['type'];
      String description = 'Código tarea: ' +
          dataJson['Codigo'].toString() +
          ' Nombre: ' +
          dataJson['Nombre'];
      await flutterLocalNotificationsPlugin.show(
          1, title, description, notificationDetails);
    }
  } catch (e) {
    print(e);
  }
}
