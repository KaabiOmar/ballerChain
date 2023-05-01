import 'package:ballerchain/model/user.dart';
import 'package:ballerchain/utils/shared_preference.dart';
import 'package:ballerchain/view/TouchID.dart';
import 'package:ballerchain/view/adminPage.dart';
import 'package:ballerchain/view/landing_page.dart';
import 'package:ballerchain/view/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ballerchain/common/theme_helper.dart';
import 'package:ballerchain/viewModel/login_view_model.dart';
import 'package:ballerchain/view//forgot_password_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _loginViewModel = LoginViewModel();
  late Future<User> _futureUser;

  double _headerHeight = 250;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? email;
  String? password;

  //final String _baseUrl = "172.25.64.1:9095";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgrnd.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 280,
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo.png',
                        height: 120, // ajuster la hauteur de l'image
                        fit: BoxFit.contain),
                  ),
                ),
                SafeArea(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      margin: EdgeInsets.fromLTRB(
                          20, 0, 20, 10), // This will be the login form
                      child: Column(
                        children: [
                          Text(
                            'BallerChain',
                            style: TextStyle(
                                fontSize: 47,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Signin into your account',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 30.0),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: ThemeHelper()
                                          .textInputDecoration(
                                              'Email', 'Enter your email'),
                                    ),
                                    decoration: ThemeHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 30.0),
                                  Container(
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: ThemeHelper()
                                          .textInputDecoration('Password',
                                              'Enter your password'),
                                    ),
                                    decoration: ThemeHelper()
                                        .inputBoxDecorationShaddow(),
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
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: ThemeHelper()
                                        .buttonBoxDecoration(context),
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
                                                  _emailController.text,
                                                  _passwordController.text)
                                              .then((_) {
                                            if (_loginViewModel.roleLogin ==
                                                "admin") {
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
                                                        TouchIdLogin()),
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
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "Don\'t have an account? ",
                                          style:
                                              TextStyle(color: Colors.white70)),
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
                                            color:
                                                Colors.purpleAccent.shade400),
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
        ],
      ),
    );
  }
}
