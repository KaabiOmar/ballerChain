import 'package:ballerchain/view/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class TouchIdLogin extends StatefulWidget {
  @override
  _TouchIdLoginState createState() => _TouchIdLoginState();
}

class _TouchIdLoginState extends State<TouchIdLogin> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool canCheckBiometrics = false;

  @override
  void initState() {
    super.initState();
    checkBiometrics();
  }

  Future<void> checkBiometrics() async {
    try {
      canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    if (canCheckBiometrics) {
      try {
        authenticated = await _localAuthentication.authenticate(
          localizedReason: 'Please authenticate to login',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        );
      } catch (e) {
        print(e);
      }
    }
    if (!mounted) return;
    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Touch ID'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Touch to Login'),
          onPressed: () {
            _authenticate();
          },
        ),
      ),
    );
  }
}
