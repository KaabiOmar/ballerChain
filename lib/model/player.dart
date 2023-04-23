class Player {
  int? _playerID;
  String _name = "";
  String? _position;
  int _team = 0;
  String? _teamName;
  String? _teamImage;
  double? _price = 1;
  int? _points = 0;
  int? _pointsWeek = 0;
  int? _appearances = 0;
  int? _subAppearances = 0;
  int? _goals = 0;
  int? _assists = 0;
  int? _cleanSheets = 0;
  int? _motms = 0;
  int? _ownGoals = 0;
  int? _redCards = 0;
  int? _yellowCards = 0;
  bool _isFresher = false;
  String _image = "";

  Player(this._playerID,
      this._name,
      this._position,
      this._team,
      this._teamName,
      this._teamImage,
      this._price,
      this._points,
      this._pointsWeek,
      this._appearances,
      this._subAppearances,
      this._goals,
      this._assists,
      this._cleanSheets,
      this._motms,
      this._ownGoals,
      this._redCards,
      this._yellowCards,
      this._isFresher,
      this._image);


  Player.withName(this._name, this._teamName, this._teamImage);

  Player.test(this._name, this._price, this._image);


  String get image => _image;

  set image(String value) {
    _image = value;
  }

  bool get isFresher => _isFresher;

  set isFresher(bool value) {
    _isFresher = value;
  }

  int? get yellowCards => _yellowCards;

  set yellowCards(int? value) {
    _yellowCards = value;
  }

  int get team => _team;

  set team(int value) {
    _team = value;
  }

  int? get redCards => _redCards;

  set redCards(int? value) {
    _redCards = value;
  }

  int? get ownGoals => _ownGoals;

  set ownGoals(int? value) {
    _ownGoals = value;
  }

  int? get motms => _motms;

  set motms(int? value) {
    _motms = value;
  }

  int? get cleanSheets => _cleanSheets;

  set cleanSheets(int? value) {
    _cleanSheets = value;
  }

  int? get assists => _assists;

  set assists(int? value) {
    _assists = value;
  }

  int? get goals => _goals;

  set goals(int? value) {
    _goals = value;
  }

  int? get subAppearances => _subAppearances;

  set subAppearances(int? value) {
    _subAppearances = value;
  }

  int? get appearances => _appearances;

  set appearances(int? value) {
    _appearances = value;
  }

  int? get pointsWeek => _pointsWeek;

  set pointsWeek(int? value) {
    _pointsWeek = value;
  }

  int? get points => _points;

  set points(int? value) {
    _points = value;
  }

  double? get price => _price;

  set price(double? value) {
    _price = value;
  }

  String? get teamName => _teamName;

  set teamName(String? value) {
    _teamName = value;
  }

  String? get teamImage => _teamImage;

  set teamImage(String? value) {
    _teamImage = value;
  }

  String? get position => _position;

  set position(String? value) {
    _position = value;
  }


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int? get playerID => _playerID;

  set playerID(int? value) {
    _playerID = value;
  }
}