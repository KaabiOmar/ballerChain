import 'package:ballerchain/utils/shared_preference.dart';
import 'package:ballerchain/view/adminPage.dart';
import 'package:ballerchain/view/landing_page.dart';
import 'package:ballerchain/view/profile_page.dart';
import 'package:ballerchain/view/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ballerchain/common/theme_helper.dart';
import 'package:ballerchain/viewModel/login_view_model.dart';
import 'package:ballerchain/view//forgot_password_page.dart';
import 'package:ballerchain/pages//widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _loginViewModel = LoginViewModel();

  double _headerHeight = 250;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstnameController, _passwordController;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? firstname;
  String? password;

  //final String _baseUrl = "172.25.64.1:9095";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight,
                  true,
                  Image.asset(
                      'assets/images/logo.png')), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'BallerChain',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: _firstnameController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Username', 'Enter your username'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordPage()),
                                    );
                                  },
                                  child: Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Sign In'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      await _loginViewModel
                                          .login(
                                              context,
                                              _firstnameController.text,
                                              _passwordController.text)
                                          .then((_) {
                                        if (_firstnameController.text ==
                                            "omar") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminPage()),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LandingPage()),
                                          );
                                        }

                                        //  Navigator.pushNamed(context, bottomNavigationRoute);
                                        // Navigate to success screen
                                        print(SharedPreference.getUserId()
                                            .toString());
                                        print("success !!");
                                      }).catchError((error) {
                                        // Handle signup error
                                      });
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Don\'t have an account? "),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
