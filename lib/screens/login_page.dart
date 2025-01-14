import 'package:bizzytasks_app/models/user_model.dart';
import 'package:bizzytasks_app/screens/home_page.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:bizzytasks_app/widgets/button_widget.dart';
import 'package:bizzytasks_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const id = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user = User();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool isDiseabledButton = true;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override

// Valida si existe un token de sesión grabado
  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') != null) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'BizzyTasks',
              style: TextStyle(
                color: LightColors.kDarkBlue,
                fontSize: 30.0,
              ),
            ),
            // SizedBox(
            //   height: 80.0,
            // ),
            MyTextField(
              label: "Email",
              controller: _emailController,
              icon: Icon(Icons.email),
              inputType: TextInputType.emailAddress,
              onChanged: (value) {
                // email = value;
                validateField();
              },
            ),
            MyTextField(
              label: "Contraseña",
              controller: _passwordController,
              icon: Icon(Icons.lock),
              obscureText: true,
              onChanged: (value) {
                // password = value;
                validateField();
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            ButtonWidget(
                tittleButton: 'Ingresar',
                isLoading: isLoading,
                disabled: isDiseabledButton,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  dynamic token = await user.getToken(
                      context: context,
                      email: _emailController.text,
                      password: _passwordController.text);
                  setState(() {
                    isLoading = false;
                  });
                  if (token != null) {
                    await user.setToken(token);
                    Navigator.pushReplacementNamed(context, HomePage.id);
                  }
                })
          ],
        ),
      ),
    );
  }

  validateField() {
    setState(() {
      if (_emailController.text == '' || _passwordController.text == '') {
        isDiseabledButton = true;
      } else {
        isDiseabledButton = false;
      }
    });
  }
}
