import 'package:ballerchain/model/news.dart';
import 'package:ballerchain/utils/shared_preference.dart';
import 'package:ballerchain/view/chatView.dart';
import 'package:ballerchain/view/fantasy.dart';
import 'package:ballerchain/view/latest.dart';
import 'package:ballerchain/view/more.dart';
import 'package:ballerchain/view/portfolioView.dart';
import 'package:ballerchain/view/profile_page.dart';
import 'package:ballerchain/view/stats.dart';
import 'package:ballerchain/viewModel/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pedometer/pedometer.dart';

import 'package:permission_handler/permission_handler.dart';
import '../common/theme_helper.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final NewsViewModel _newsViewModel = NewsViewModel();

  List<News> _news = [];
  bool _showContent = true;
  bool _showHeader = false;
  int _selectedIndex = 0;

  Pedometer _pedometer = Pedometer();
  late Stream<StepCount> _stepCountStream;
  int _stepsCount = 0;
  int _initialStepsCount = 0;
  List<News> _newslist = [];

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    _getNews();
  }

  void _initPlatformState() async {
    PermissionStatus status = await Permission.activityRecognition.request();

    // Demande de permission pour accéder aux capteurs de podomètre
    if (status == PermissionStatus.granted) {
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

  void _getNews() async {
    try {
      List<News> news = await _newsViewModel.getNews();
      setState(() {
        _newslist = news;
      });
    } catch (error) {
      print('failed to load news : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /* Positioned.fill(
              bottom: 0,
              child: _screens[_selectedIndex],
          ),*/
          Image.asset(
            'assets/images/bgrnd.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, controller) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    setState(() {
                      _showContent = notification.extent < 0.5 &&
                          notification.extent > 0.0;
                      _showHeader = notification.extent > 0.6;
                      print(_showHeader);
                    });
                    return true;
                  },
                  child: Column(
                    children: [
                      if (_showHeader)
                        Container(
                          width: 400,
                          height: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 20.0,
                                left: 20.0,
                                child: Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Text(
                                    'BallerChain',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      Expanded(
                          child: ListView.builder(
                        controller: controller,
                        itemCount: _newslist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.black26, // Couleur de fond
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(_newslist[index].image!,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              title: Text(
                                _newslist[index].title!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.purple,
                                ),
                              ),
                              subtitle: Text(
                                _newslist[index].content_text!,
                                style: TextStyle(
                                  color: Colors
                                      .white70, // Couleur du texte du sous-titre
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                ),
              );
            },
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: _showContent ? 1.0 : 0.0,
            child: SafeArea(
              child: Stack(
                children: [
                  // Add your landing page content here

                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        '1 Coin =1000 Step',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    left: 20.0,
                    child: Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          onPressed: () {
                            // Do something when the button is pressed
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  String? userId;
                                  SharedPreference.getUserId().then((value) {
                                    userId = value;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileView(userId: userId!)));
                                  });
                                },
                                child: Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: (Positioned(
                      top: 120,
                      right: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${_stepsCount.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 55.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'steps today',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 30,
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PortfolioPage()), // Remplacez PortfolioPage() par le nom de votre classe de la page du portfolio
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.wallet,
                                          color: Colors.white, size: 14),
                                      SizedBox(width: 7),
                                      Text("Portfolio",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10.0)),
                                      SizedBox(width: 5),
                                      Icon(Icons.arrow_forward,
                                          color: Colors.white, size: 12)
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )),
                  ),
                  Positioned(
                    top: 280,
                    left: 30,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: ThemeHelper()
                                            .buttonBoxDecoration2(context),
                                        child: ElevatedButton(
                                            style: ThemeHelper().buttonStyle(),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Send coins'),
                                                    backgroundColor:
                                                        Colors.deepPurple,
                                                    content: Container(
                                                      width: 500.0,
                                                      height: 100.0,
                                                      child: Column(

                                                        children: [
                                                          Expanded(
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Enter a wallet (username or address)',
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 16.0),
                                                          Expanded(
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Amount',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      Container(
                                                        decoration: ThemeHelper()
                                                            .buttonBoxDecoration(
                                                                context),
                                                        child: ElevatedButton(
                                                          style: ThemeHelper()
                                                              .buttonStyle5(),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Confirm',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(Icons.send_to_mobile,
                                                    color: Colors.white,
                                                    size: 30),
                                              ],
                                            )),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Send',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: ThemeHelper()
                                            .buttonBoxDecoration2(context),
                                        child: ElevatedButton(
                                            style: ThemeHelper().buttonStyle(),
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                    Icons
                                                        .account_balance_wallet_outlined,
                                                    color: Colors.white,
                                                    size: 30),
                                              ],
                                            )),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Buy',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: ThemeHelper()
                                            .buttonBoxDecoration2(context),
                                        child: ElevatedButton(
                                            style: ThemeHelper().buttonStyle(),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    title: Text(''),
                                                    content: Stack(
                                                      children: [
                                                        Container(
                                                          width: 500.0,
                                                          height: 500.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/grow.png'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                                bottom:
                                                                    10.0), // Ajuster la marge vers le haut
                                                            width: 200,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary: Colors
                                                                    .deepPurple,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                'GROW',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [], // Supprimer la liste d'actions
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(Icons.inventory_2_outlined,
                                                    color: Colors.white,
                                                    size: 30),
                                              ],
                                            )),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Grow',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: ThemeHelper()
                                            .buttonBoxDecoration2(context),
                                        child: ElevatedButton(
                                            style: ThemeHelper().buttonStyle(),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Convert your steps'),
                                                    backgroundColor:
                                                        Colors.deepPurple,
                                                    content: Container(
                                                      width: 500.0,
                                                      height: 100.0,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              '1 Coin =1000 Step',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,fontSize: 14)),
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Steps',
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      Container(
                                                        decoration: ThemeHelper()
                                                            .buttonBoxDecoration(
                                                                context),
                                                        child: Center(
                                                          child: ElevatedButton(
                                                            style: ThemeHelper()
                                                                .buttonStyle5(),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              'Confirm',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                    Icons
                                                        .swap_horizontal_circle_outlined,
                                                    color: Colors.white,
                                                    size: 30),
                                              ],
                                            )),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Convert',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: ThemeHelper().buttonBoxDecoration2(context),
                      margin: EdgeInsets.all(10),
                      child: GNav(
                          rippleColor: Colors
                              .deepPurple, // tab button ripple color when pressed
                          hoverColor:
                              Colors.deepPurple, // tab button hover color
                          haptic: true, // haptic feedback
                          tabBorderRadius: 80,
                          curve: Curves.easeOutExpo, // tab animation curves
                          duration: Duration(
                              milliseconds: 500), // tab animation duration
                          gap: 8, // the tab button gap between icon and text
                          color: Colors.white, // unselected icon color
                          activeColor:
                              Colors.white, // selected icon and text color
                          iconSize: 24, // tab button icon size
                          padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10), // navigation bar padding
                          selectedIndex: _selectedIndex,
                          onTabChange: (index) {
                            setState(() {
                              print(index);
                              _selectedIndex = index;
                            });
                          },
                          tabs: [
                            GButton(
                              icon: Icons.home,
                              text: 'Home',
                              onPressed: () {
                                // Navigate to the Profile interface
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LandingPage()),
                                );
                              },
                            ),
                            GButton(
                              icon: Icons.chat,
                              text: 'Chat',
                              onPressed: () {
                                // Navigate to the Profile interface
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen()),
                                );
                              },
                            ),
                            GButton(
                              icon: Icons.search,
                              text: 'Search',
                              onPressed: () {
                                // Navigate to the Profile interface
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Fantasy()),
                                );
                              },
                            ),
                            GButton(
                              icon: Icons.person_off,
                              text: 'Profile',
                              onPressed: () {
                                // Navigate to the Profile interface
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Stats()),
                                );
                              },
                            ),
                            GButton(
                              icon: Icons.person_2,
                              text: 'test',
                              onPressed: () {
                                // Navigate to the Profile interface
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => More()),
                                );
                              },
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
