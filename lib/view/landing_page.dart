import 'package:ballerchain/utils/shared_preference.dart';
import 'package:ballerchain/view/fantasy.dart';
import 'package:ballerchain/view/latest.dart';
import 'package:ballerchain/view/more.dart';
import 'package:ballerchain/view/profile_page.dart';
import 'package:ballerchain/view/stats.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../common/theme_helper.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _showContent = true;
  bool _showHeader = false;
  int _selectedIndex = 0;

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
            'assets/images/sweatcoin_bg.png',
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
                                right: 20.0,
                                child: Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Text(
                                    'Balance = 70.09',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
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
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 200,
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage('assets/images/first.jpg'),
                                fit: BoxFit.cover,
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
                        '1 = 1000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: Container(
                      decoration: ThemeHelper().buttonBoxDecoration2(context),
                      child: ElevatedButton(
                          style: ThemeHelper().buttonStyle3(),
                          onPressed: () {
                            // Do something when the button is pressed
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  String? userId;
                                  SharedPreference.getUserId()
                                      .then((value) {
                                    userId = value;
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileView(
                                                    userId: userId!)),
                                            (route) => false);
                                  });
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.purple,
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: (Positioned(
                      top: 150,
                      left: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 50.0,
                                height: 50.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '79.06',
                                style: TextStyle(
                                  fontSize: 60.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Available',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Image.asset(
                                'assets/images/logo.png',
                                width: 15.0,
                                height: 15.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '79.06',
                                style: TextStyle(
                                  fontSize: 15.0,
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
                                  // Do something when the button is pressed
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.wallet,
                                          color: Colors.white, size: 12),
                                      SizedBox(width: 5),
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
                    top: 300,
                    left: 20,
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
                                            style: ThemeHelper().buttonStyle2(),
                                            onPressed: () {
                                              // Do something when the button is pressed
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(Icons.transform_outlined,
                                                    color: Colors.white,
                                                    size: 30),
                                              ],
                                            )),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Transfer',
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
                                            style: ThemeHelper().buttonStyle2(),
                                            onPressed: () {
                                              // Do something when the button is pressed
                                            },
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
                                            style: ThemeHelper().buttonStyle2(),
                                            onPressed: () {
                                              // Do something when the button is pressed
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(Icons.inventory_2_sharp,
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
                                            style: ThemeHelper().buttonStyle2(),
                                            onPressed: () {
                                              // Do something when the button is pressed
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(Icons.swap_horiz_outlined,
                                                    color: Colors.white,
                                                    size: 30),
                                              ],
                                            )),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Swap',
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
                              icon: Icons.health_and_safety,
                              text: 'Likes',
                              onPressed: () {
                                // Navigate to the Profile interface
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Latest()),
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
