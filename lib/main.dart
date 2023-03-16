import 'package:ballerchain/SplashScreen.dart';
import 'package:ballerchain/view/login.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(LoginUI());
}

class LoginUI extends StatelessWidget {
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
      home: SplashScreen(),

    );
  }
}
