import 'package:bizzytasks_app/provider/list_app_provider.dart';
import 'package:bizzytasks_app/provider/tasks_provider.dart';
import 'package:bizzytasks_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:bizzytasks_app/screens/home_page.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: Color(0xffffb969), // status bar color
  ));

  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ListAppProvider()),
      ChangeNotifierProvider(create: (_) => TaskProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'),
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage()
      },
      // home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
