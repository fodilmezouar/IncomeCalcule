import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'recette.dart';

class DBHelper {
  static Database _db;
  static DBHelper _dbHelper;
  static const String ID = 'id';
  static const String RECETTEJ = 'recetteJ';
  static const String DESCRIPTION = 'description';
  static const String DEPENSEJ = 'depenseJ';
  static const String TOT = 'tot';
  static const String DATE = 'date';
  static const String TABLE = 'Recette';
  static const String DB_NAME = 'recette.db';

  DBHelper._createInstance();

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _dbHelper;
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'recette.db';

		// Open/create the database at a given path
		var recetteDatabase = await openDatabase(path, version: 1, onCreate: _onCreate);
		return recetteDatabase;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $RECETTEJ INTEGER, $DEPENSEJ INTEGER, $DESCRIPTION TEXT, $TOT INTEGER, $DATE TEXT)");
  }

  Future<int> insertRecette(Recette recette) async {
    Database dbb = await this.db;
    var result = await dbb.insert(TABLE, recette.toMap());
    return result;
  }

  Future<int> updateRecette(Recette recette) async {
    var db = await this.db;
    var result = await db.update(TABLE, recette.toMap(),
        where: '$ID = ?', whereArgs: [recette.id]);
    return result;
  }

  Future<int> deleteRecette(int id) async {
    var db = await this.db;
    int result = await db.rawDelete('DELETE FROM $TABLE WHERE $ID = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $TABLE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
Future<int> getTotal(int month,String year) async {
    Database db = await this.db;
    List<Map<String, dynamic>> x =
        await db.rawQuery("SELECT SUM($TOT),strftime('%m',$DATE) as month,strftime('%Y',$DATE) as year from $TABLE WHERE  month ='$month' and year = '$year'" );
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  Future<int> getTotalYear(String year) async {
    Database db = await this.db;
    List<Map<String, dynamic>> x =
        await db.rawQuery("SELECT SUM($TOT),strftime('%m',$DATE) as month,strftime('%Y',$DATE) as year from $TABLE WHERE   year = '$year'" );
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  Future<List<Recette>> getRecetteList() async {
		var recetteMapList = await getrecetteMapList(); // Get 'Map List' from database
		int count = recetteMapList.length;         // Count the number of map entries in db table

		List<Recette> recetteList = List<Recette>();
		// For loop to create a 'Recette List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			recetteList.add(Recette.fromMapObject(recetteMapList[i]));
		}

		return recetteList;
	}
  Future<List<Map<String, dynamic>>> getrecetteMapList() async {
		Database db = await this.db;

		var result = await db.rawQuery('SELECT * FROM $TABLE order by $DATE ASC');
		return result;
	}
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

}
