class Recette {
  int _id;
  int _recetteJ;
  int _depenseJ;
  int _tot;
  String _description;
  String _date;

  Recette(this._id,this._recetteJ,this._depenseJ,this._tot,this._date,[this._description]);
  int get id => _id;
  int get recetteJ => _recetteJ;
  int get depenseJ => _depenseJ;
  int get tot => _tot;
  String get description => _description;
  String get date => _date;

  set recetteJ(int newrecetteJ){
    this._recetteJ = newrecetteJ;

  }
  set depenseJ(int newrecetteJ){
    this._depenseJ = newrecetteJ;
  }
  set date(String newdate){
    this._date = newdate;
  }
  Map<String,dynamic> toMap(){
    var map =  Map<String,dynamic>();
    if (id != null) {
			map['id'] = _id;
		}
    map['recetteJ'] = _recetteJ;
		map['description'] = _description;
		map['depenseJ'] = _depenseJ;
    map['tot'] = _tot;
		map['date'] = _date;

    return map;
  }
  Recette.fromMapObject(Map<String,dynamic> map){
    this._id = map['id'];
		this._tot = map['tot'];
		this._description = map['description'];
		this._recetteJ = map['recetteJ'];
    this._depenseJ = map['depenseJ'];
		this._date = map['date'];
  }
}
