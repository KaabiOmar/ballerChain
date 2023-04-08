import 'package:ballerchain/SplashScreen.dart';

import 'package:ballerchain/utils/routes.dart';
import 'package:ballerchain/view/forgot_password_page.dart';
import 'package:ballerchain/view/login.dart';
import 'package:ballerchain/view/profile_page.dart';
import 'package:ballerchain/view/registration.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  //LoginUI({super.key});
  Color _primaryColor =HexColor('#2b103b');
  Color _accentyColor =HexColor('#5c1757');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BallerChain',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentyColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      initialRoute: splashScreen, // Définir la première interface à afficher
      routes: {
        // Définir les routes pour chaque interface
        splashScreen: (context) => SplashScreen(),
        loginRoute: (context) => LoginPage(),
        signUpRoute: (context) => RegistrationPage(),
        forgetPasswordRoute: (context) => ForgotPasswordPage(),
      },
    );
  }
}
