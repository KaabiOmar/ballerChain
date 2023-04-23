import 'package:ballerchain/viewModel/admin_view_model.dart';
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
  final AdminViewModel _adminViewModel = AdminViewModel();
  List<User> _usersList = [];
  int _selectedUserId = -1; // ID de l'utilisateur sélectionné pour l'expansion

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

  Future<void> _refreshUsers() async {
    // Perform any async operation to refresh the data
    // For example, fetch data from an API
    await Future.delayed(Duration(seconds: 2));
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page',
          style: TextStyle(color: Colors.white),
        ),centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bgrnd.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgrnd.png'),
            fit: BoxFit.cover,
          ),
        ),

      child: RefreshIndicator(
        onRefresh: _refreshUsers,
        child: ListView.builder(
          itemCount: _usersList.length,
          itemBuilder: (BuildContext context, int index) {
            User user = _usersList[index];
            bool isExpanded = index == _selectedUserId;

            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ExpansionPanelList(
                expansionCallback: (int userId, bool isExpanded) {
                  setState(() {
                    _selectedUserId = isExpanded ? -1 : index;
                  });
                },
                children: [
                  ExpansionPanel(

                    isExpanded: isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {

                      return ListTile(
                        title: Text(user.email!),
                        subtitle: Text(user.firstname!),
                      );
                    },
                    body: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FirstName: ${user.firstname}'),
                          SizedBox(height: 8.0),
                          Text('LastName: ${user.lastname}'),
                          SizedBox(height: 8.0),
                          Text('Phone Number: ${user.phonenumber}'),
                          SizedBox(height: 8.0),
                          Text('Birthday: ${user.birthday}'),
                          SizedBox(height: 8.0),
                          Text('Steps: ${user.steps} step'),
                          SizedBox(height: 8.0),
                          Text('Coins: ${user.coins} coin'),
                          SizedBox(height: 8.0),
                          Text('Blocked: ${user.block == 1 ? 'Oui' : 'Non'}'),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // Aligner les boutons horizontalement
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _adminViewModel.blockUser(context, user.id!);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent.shade100,
                                  minimumSize: Size(100, 48.0),
                                ),
                                child: Text('Block User'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _adminViewModel.unblockUser(
                                      context, user.id!);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  minimumSize: Size(100, 48.0),
                                ),
                                child: Text('Unblock User'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _adminViewModel.deleteUser(context, user.id!);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  minimumSize: Size(
                                      100, 48.0), // Taille minimale du bouton
                                ),
                                child: Text('Delete User'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}
