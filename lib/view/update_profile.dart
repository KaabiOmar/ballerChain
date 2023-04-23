import 'package:ballerchain/model/user.dart';
import 'package:ballerchain/view/profile_page.dart';
import 'package:ballerchain/viewModel/update_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared_preference.dart';
import '../viewModel/profile_view_model.dart';

class UpdateProfilePage extends StatefulWidget {
  final String userId;

  UpdateProfilePage({required this.userId});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late Future<User> _futureUser;

  // Les contrôleurs de texte pour les champs de saisie
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureUser = ProfileViewModel().fetchUserById(widget.userId);

    // Récupérer les données de l'utilisateur à partir de SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      _firstNameController.text = prefs.getString('firstName') ?? '';
      _lastNameController.text = prefs.getString('lastName') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneNumberController.text = prefs.getString('phoneNumber') ?? '';
      _birthdayController.text = prefs.getString('birthday') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le profil'),
      ),
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data!;
            return Container(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: user.firstname,
                      decoration: InputDecoration(
                        labelText: 'Prénom',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (value) {
                        setState(() {
                          user.firstname = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: user.lastname,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (value) {
                        setState(() {
                          user.lastname = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: user.email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      onChanged: (value) {
                        setState(() {
                          user.email = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: user.phonenumber,
                      decoration: InputDecoration(
                        labelText: 'Numéro de téléphone',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      onChanged: (value) {
                        setState(() {
                          user.phonenumber = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: user.birthday,
                      decoration: InputDecoration(
                        labelText: 'Date de naissance',
                        prefixIcon: Icon(Icons.cake),
                      ),
                      onChanged: (value) {
                        setState(() {
                          user.birthday = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        String? userId;
                        SharedPreference.getUserId().then((value) {
                          userId = value;
                          _futureUser = UpdateProfileViewModel().updateProfile(userId! , user);

                          _futureUser.then((updatedUser) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profil mis à jour'),duration: Duration(seconds: 4),
                              backgroundColor:Colors.green ));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileView(userId: updatedUser.id!)));
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la mise à jour du profil'),duration: Duration(seconds: 4),
                              backgroundColor:Colors.red ));
                          });
                        });
                      },
                      child: Text('Enregistrer'),
                    ),

                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

}
