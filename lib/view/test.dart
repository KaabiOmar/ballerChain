/*
void main(){
  runApp(MyApp());
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Pedometer _pedometer = Pedometer();
  late Stream<StepCount> _stepCountStream;
  int _stepsCount = 0;
  int _initialStepsCount = 0;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  void _initPlatformState() async {
    // Demande de permission pour accéder aux capteurs de podomètre
    if (await Permission.activityRecognition.request().isGranted) {
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(_onStepCount);
      print("aaaaaa");
    }
  }
  /* if (await Permission.activityRecognition.request().isGranted) {
      _stepCountStream = Pedometer.stepCountStream;
      var subscription = _stepCountStream.listen(_onStepCount);
      if (_stepsCount >= 20) {
        subscription.cancel(); // Stop listening to step count stream
      }
    }*/

  void _onStepCount(StepCount event) {
    setState(() {
      _stepsCount = event.steps;
    });
  }

  void _resetStepsCount() {
    setState(() {
      _initialStepsCount = _stepsCount;
      _stepsCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.directions_walk, size: 80),
            Text(
              '${_stepsCount.toString().padLeft(2, '0')} /50',
              style: TextStyle(fontSize: 50),
            ),
            ElevatedButton(
              onPressed: _resetStepsCount,
              child: Text('Réinitialiser'),
            ),
            Text(
              '$_initialStepsCount pas initiaux',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:ballerchain/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le profil'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16.0),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  labelText: 'Date de naissance',
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                // Remplacez par la couleur de votre thème
                onPressed: () {
                  // TODO: Enregistrer les données du profil
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
