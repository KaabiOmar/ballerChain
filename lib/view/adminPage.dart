import 'package:ballerchain/viewModel/usersViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final UsersViewModel _usersViewModel = UsersViewModel();
  List<User> _usersList = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() async {
    List<User> users = await _usersViewModel.getAllUser();
    setState(() {
      _usersList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: ListView.builder(
        itemCount: _usersList.length,
        itemBuilder: (BuildContext context, int index) {
          User user = _usersList[index];
          return ListTile(
            title: Text(user.firstname!),
            subtitle: Text(user.email!),
          );
        },
      ),
    );
  }
}
