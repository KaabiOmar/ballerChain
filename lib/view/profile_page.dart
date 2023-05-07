import 'package:ballerchain/common/theme_helper.dart';
import 'package:ballerchain/utils/shared_preference.dart';
import 'package:ballerchain/view/login.dart';
import 'package:ballerchain/view/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:ballerchain/model/user.dart';
import 'package:ballerchain/viewmodel/profile_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileView extends StatefulWidget {
  final String userId;

  ProfileView({required this.userId});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = ProfileViewModel().fetchUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/bgrnd.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      padding: EdgeInsets.fromLTRB(10, 50, 10, 350),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 60.0, bottom: 14.0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Account Informations :",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Card(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            ...ListTile.divideTiles(
                                              color: Colors.deepPurple,
                                              tiles: [
                                                ListTile(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  leading: Icon(
                                                      Icons.account_circle),
                                                  title: Text("Firstname"),
                                                  subtitle: Text(
                                                      'Firstname: ${user.firstname}'),
                                                ),
                                                ListTile(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  leading: Icon(
                                                      Icons.account_circle_rounded),
                                                  title: Text("Lastname"),
                                                  subtitle: Text(
                                                      'Lastname: ${user.lastname}'),
                                                ),
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 4),
                                                  leading: Icon(
                                                      Icons.calendar_today),
                                                  title: Text("Birthday"),
                                                  subtitle: Text(
                                                      'Birthday: ${user.birthday}'),
                                                ),
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 4),
                                                  leading: Icon(Icons.email),
                                                  title: Text("Email"),
                                                  subtitle: Text(
                                                      'Email: ${user.email}'),
                                                ),
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 4),
                                                  leading: Icon(Icons.phone),
                                                  title: Text("Phone"),
                                                  subtitle: Text(
                                                      'Phone: ${user.phonenumber}'),
                                                ),
                                                ListTile(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  leading: Icon(Icons.currency_exchange_outlined),
                                                  title: Text("Coins"),
                                                  subtitle: Text(
                                                      'Coins: ${user.coins} coin'),
                                                ),
                                                SizedBox(
                                                  height: 20,
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
                                                        'Logout'.toUpperCase(),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                                      await preferences.clear().then((value) =>    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                                      ));
                                                    },

                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      appBar: AppBar(
        title: Text(
          'My profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close,color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.mode_edit,color: Colors.white),
            onPressed: () {
              String? userId;
              SharedPreference.getUserId().then((value) {
                userId = value;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateProfilePage(userId: userId!)));
              });
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bgrnd.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
