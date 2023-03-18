import 'package:ballerchain/view/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:ballerchain/model/user.dart';
import 'package:ballerchain/viewmodel/profile_view_model.dart';

import '../common/theme_helper.dart';
import '../pages/widgets/header_widget.dart';

class ProfileView extends StatefulWidget {
  final String userId;

  ProfileView({required this.userId});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<User> _futureUser;
  double _headerHeight = 250;

  @override
  void initState() {
    super.initState();
    _futureUser = ProfileViewModel().fetchUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(height: 100, child: HeaderWidget(_headerHeight,
                        true,
                        Image.asset(
                            'assets/images/logo.png'))),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 5, color: Colors.white),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                              ],
                            ),
                            child: Image.network(' ${user.image}'),
                          ),
                          SizedBox(height: 20,),
                          Text('Name: ${user.firstname} ${user.lastname}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Account Informations",
                                    style: TextStyle(
                                      color: Colors.black87,
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
                                              color: Colors.grey,
                                              tiles: [
                                                ListTile(
                                                  contentPadding: EdgeInsets.symmetric(
                                                      horizontal: 12, vertical: 4),
                                                  leading: Icon(Icons.my_location),
                                                  title: Text("Birthday"),
                                                  subtitle: Text('Birthday: ${user.birthday}'),
                                                ),
                                                ListTile(
                                                  contentPadding: EdgeInsets.symmetric(
                                                      horizontal: 12, vertical: 4),
                                                  leading: Icon(Icons.email),
                                                  title: Text("Email"),
                                                  subtitle: Text('Email: ${user.email}'),
                                                ),
                                                ListTile(
                                                  contentPadding: EdgeInsets.symmetric(
                                                      horizontal: 12, vertical: 4),
                                                  leading: Icon(Icons.phone),
                                                  title: Text("Phone"),
                                                  subtitle: Text('Phone: ${user.phonenumber}'),
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
    );
  }
}
