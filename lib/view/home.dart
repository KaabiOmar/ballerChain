import 'package:ballerchain/pages/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _headerHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          height: _headerHeight,
          child: HeaderWidget(
              _headerHeight,
              true,
              Image.asset(
                  'assets/images/logo.png')), //let's create a common header widget
        )));
  }
}
