import 'package:ballerchain/model/player.dart';
import 'package:ballerchain/view/chatView.dart';
import 'package:ballerchain/view/leagues.dart';
import 'package:ballerchain/view/stats.dart';
import 'package:ballerchain/view/test.dart';
import 'package:ballerchain/view/test2.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../common/theme_helper.dart';
import 'landing_page.dart';
import 'latest.dart';
import 'more.dart';

class Fantasy extends StatefulWidget {
  @override
  _FantasyState createState() => _FantasyState();
}

class _FantasyState extends State<Fantasy> {
  int _selectedIndex = 2;
  List<Player> players = [
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
    Player.withName("De Brueyn", "Manchester City", "assets/images/city.png"),
  ];
  List<Player> playa = [
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
    Player(1, "De Brueyn", "Forward", 1, "PSG", "psg.png", 3, 1200, 80, 30, 2,
        25, 5, 0, 0, 12, 8, 0, false, "assets/images/cityy.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/fantasy_bg.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 80,
                  left: 10,
                  right: 10,
                  // Add your landing page content here
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Opacity(
                          opacity: 1,
                          child: Center(
                            child: Text(
                              'Username',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 100,
                              child: Container(
                                height: 40,
                                width: 200,
                                decoration:
                                    ThemeHelper().buttonBoxDecoration1(context),
                                child: Center(
                                  child: Text(
                                    "Gameweek 28",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 40,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("38",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 40)),
                                      Text(
                                        "Average",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Container(
                                      height: 130,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white.withOpacity(0.7)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "60",
                                            style: TextStyle(
                                              fontSize: 60,
                                            ),
                                          ),
                                          Text("Points"),
                                        ],
                                      )),
                                  SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Text(
                                        "116",
                                        style: TextStyle(
                                          fontSize: 40,
                                        ),
                                      ),
                                      Text("Highest"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 100,
                              child: Container(
                                height: 40,
                                width: 200,
                                decoration:
                                    ThemeHelper().buttonBoxDecoration1(context),
                                child: Center(
                                  child: Text(
                                    "Gameweek 29",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 60,
                                left: 50,
                                child: Text(
                                    "Gamweek 29 deadline: Tuesday 01 avr., 11:00")),
                            Positioned(
                                top: 90,
                                left: 3,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          decoration: ThemeHelper()
                                              .buttonBoxDecoration3(context),
                                          child: ElevatedButton(
                                              style:
                                                  ThemeHelper().buttonStyle3(),
                                              onPressed: () {
                                                // Do something when the button is pressed
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.shield_rounded,
                                                      color: Colors.white),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Pick Team",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          width: 190,
                                          decoration: ThemeHelper()
                                              .buttonBoxDecoration3(context),
                                          child: ElevatedButton(
                                              style:
                                                  ThemeHelper().buttonStyle3(),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Test(
                                                              selectedPlayers:
                                                                  playa)),
                                                ); // Do something when the button is pressed
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.arrow_forward,
                                                      color: Colors.white),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Transfers",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          decoration: ThemeHelper()
                                              .buttonBoxDecoration3(context),
                                          child: ElevatedButton(
                                              style:
                                                  ThemeHelper().buttonStyle4(),
                                              onPressed: () {
                                                // Do something when the button is pressed
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Packs",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          width: 190,
                                          decoration: ThemeHelper()
                                              .buttonBoxDecoration3(context),
                                          child: ElevatedButton(
                                              style:
                                                  ThemeHelper().buttonStyle4(),
                                              onPressed: () {
                                                // Do something when the button is pressed
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Fixtures",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          decoration: ThemeHelper()
                                              .buttonBoxDecoration3(context),
                                          child: ElevatedButton(
                                              style:
                                                  ThemeHelper().buttonStyle4(),
                                              onPressed: () {
                                                // Do something when the button is pressed
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Statistics",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          width: 190,
                                          decoration: ThemeHelper()
                                              .buttonBoxDecoration3(context),
                                          child: ElevatedButton(
                                              style:
                                                  ThemeHelper().buttonStyle4(),
                                              onPressed: () {
                                                // Do something when the button is pressed
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Leagues(
                                                              players:
                                                                  players)),
                                                );
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Leagues",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 120,
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage('assets/images/first.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
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
                        hoverColor: Colors.deepPurple, // tab button hover color
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
                                MaterialPageRoute(builder: (context) => More()),
                              );
                            },
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
