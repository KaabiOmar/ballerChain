import 'package:ballerchain/common//styles.dart';
import 'package:flutter/material.dart';

import '../common/theme_helper.dart';
import '../model/player.dart';
import 'home.dart';

class Test extends StatefulWidget {
  final List<Player> selectedPlayers;

  Test({Key? key, required this.selectedPlayers}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final double _checkboxHeight = 30.0;
  double _startingBudget = 107.0;
  double _budget = 107.0;
  bool _everyTeam = false, _minThreeFreshers = false, _maxThreeSameTeam = true, _isTeamNameLong = false, _buttonEnabled = true;
  String _teamName = "";
  Widget _saveChanges = Text("Press to save changes");


  @override
  void initState() {
    Map<int, int> teamCount = {};
    int fresherCount = 0;
    print(widget.selectedPlayers.toString());
    for (Player player in widget.selectedPlayers) {
      if (player != null) {
        _budget -= player.goals!;
        if (player.isFresher) fresherCount++;
        if (teamCount[player.team] == null) {
          teamCount[player.team] = 1;
        } else {
          if (player.team != null) {
            teamCount[player.team] = (teamCount[player.team] ?? 0) + 1;
          }
          if (player.team != null) {
            if (teamCount[player.team]?.compareTo(3) == 1) {
              _maxThreeSameTeam = false;
            }
          }
        }
      }
    }
    _minThreeFreshers = fresherCount >= 3;
    _everyTeam = teamCount.length >= 7;
    super.initState();
  }


  emptyPlayer(int index) {
    Player player = widget.selectedPlayers[index];
    Widget playerView;

    if (player == null) {
      playerView = Image.asset(
        "assets/images/city.png",
        fit: BoxFit.fitHeight,
      );
    } else {
      playerView = Column(
        children: <Widget>[
          Expanded(
              child: Container(
                width: 70,
                height: 110,
                child: Image.asset(
                  player.image,
                  fit: BoxFit.scaleDown,
                ),
              )
          ),
          Container(
            padding: EdgeInsets.all(3),
            width: 60,
            height: 17,
            decoration: ThemeHelper().buttonBoxDecoration4(context),
            child: Text(
              style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),
              player.name,
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          Container(
            padding: EdgeInsets.all(3),
            width: 60,
            height: 17,
            decoration: ThemeHelper().buttonBoxDecoration5(context,"#0000","#0000"),

            child: Text(
              style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),
              "£${player.price}m",
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      );
    }

    return Expanded(
      child: InkWell(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return Home();})),
          child: Padding(padding: EdgeInsets.only(left: 3.0, right: 3.0), child:playerView,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(title: Text("Create your team"),),
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade800
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                        child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                  child: Image.asset("assets/images/pitch.jpg", fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter,)
                              )
                            ]
                        )
                    ),
                  ],
                ),
                Column( //players
                  children: <Widget>[
                    Expanded(
                        flex: 6,
                        child: Container()
                    ),


                    Expanded(
                        flex: 6,
                        child:  Padding(
                          padding: EdgeInsets.only(left: 120.0, right: 120.0), child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(2, (index) => emptyPlayer(index)),
                        ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(5, (index) =>  emptyPlayer(index+2)),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(5, (index) =>  emptyPlayer(index+7)),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child:  Padding(
                          padding: EdgeInsets.only(left: 70.0, right: 70.0), child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (index) => emptyPlayer(index)),
                        ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }

}