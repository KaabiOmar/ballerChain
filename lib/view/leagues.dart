import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../model/player.dart';

class Leagues extends StatefulWidget {
  Leagues({
    Key? key,
    required this.players,
  }) : super(key: key);

  final List<Player> players;
  @override
  _LeaguesState createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {

  String? _selectedTeam; // store the selected team value here
  final List<String> _teams = [    'All Clubs',  'Arsenal',    'Chelsea',    'Liverpool',    'Manchester City',    'Manchester United',    'Tottenham Hotspur'  ];

  String? _selectedPosition; // store the selected team value here
  final List<String> _positions = [    'All Positions',    'Goalkeepers',    'Defenders',    'Midfielders',    'Forwards' ];

  List<Player> _players = [
    Player.withName("De Brueyn","Manchester City","assets/images/city.png"),
  ];

  List<Player> _searchResult = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchResult = List.from(_players);
    print(_searchResult);
  }

  void _onSearchTextChanged(String searchText) {
    _searchResult.clear();

    if (searchText.isEmpty) {
      setState(() {_searchResult = List.from(_players);});
      return;
    }

    _players.forEach((player) {
      if (player.name!.toLowerCase().contains(searchText.toLowerCase())) {
        _searchResult.add(player);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(height:900 ,width:420 ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fantasy_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Your widgets here
            Container(
                margin: EdgeInsets.fromLTRB(20, 38, 20, 2),
                height: 50,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }
                        , icon: Icon(Icons.arrow_back),color: Colors.black ),

                    SizedBox(width: 30),
                    Text(
                      'Statistics',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
            ),
            Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        width: double.infinity,
                        height: 47,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black),
                              icon: Icon(Icons.search,color: Colors.black),
                            ),
                            onChanged: _onSearchTextChanged,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Club",
                                  style: TextStyle(
                                      color: Colors.purpleAccent,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: _selectedTeam,
                                    items: _teams.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text("All Clubs"),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedTeam = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 1),
                          Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Position",
                                  style: TextStyle(
                                      color: Colors.purpleAccent,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: _selectedPosition,
                                    items: _positions.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text("All Players"),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedPosition = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 650,
                        child:
                        HorizontalDataTable(
                          tableHeight: 650,
                          leftHandSideColumnWidth: 180,
                          rightHandSideColumnWidth: 500,
                          isFixedHeader: true,
                          headerWidgets: _getTitleWidget(),
                          leftSideItemBuilder: _generateFirstColumnRow,
                          rightSideItemBuilder: _generateRightHandSideColumnRow,
                          itemCount: widget.players.length,
                          rowSeparatorWidget: const Divider(
                            color: Colors.black54,
                            height: 1.0,
                            thickness: 0.0,
                          ),
                          leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                          rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Player', 100),
      _getTitleItemWidget('Value', 50),
      _getTitleItemWidget('Selected', 50),
      _getTitleItemWidget('GW29', 50),
      _getTitleItemWidget('Total Points', 50),
      _getTitleItemWidget('GW Transfers in', 50),
      _getTitleItemWidget('GW Transfers out', 50),
      _getTitleItemWidget('Bonus Points', 50),
      _getTitleItemWidget('GW30', 50),
      _getTitleItemWidget('GW30', 50),
      _getTitleItemWidget('GW30', 50),
    ];
  }
  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
      width: width,
      height: 30,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    );
  }
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 5),
          Container(
            child: Image.asset("assets/images/info.png"),
            width: 13,
            height: 13,
            alignment: Alignment.topRight,
          ),
          SizedBox(width: 8),
          Container(
            child: Image.asset(widget.players[index].teamImage!),
            width: 30,
            height: 30,
            alignment: Alignment.centerLeft,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.players[index].name!,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.players[index].teamName!,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(width: 20),
          Container(
            child: Image.asset("assets/images/star.png"),
            width: 13,
            height: 13,
            alignment: Alignment.topRight,
          ),
        ],
      ),
      width: 200,
      height: 52,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text("£12.1m",style: TextStyle(fontSize: 10)),
          width: 50,
          height: 45,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text("25.7%",style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text("10",style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text("120",style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text("15376",style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text("3080",style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text("20",style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.green
          ),
          child: Text("LEE(A)",style: TextStyle(fontSize: 12)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.green
          ),
          child: Text("NFO(H)",style: TextStyle(fontSize: 12)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey
          ),
          child: Text("WHU(A)",style: TextStyle(fontSize: 12)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}