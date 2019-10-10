import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'recette.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String RECETTEJ ='recetteJ';
  static const String DESCRIPTION ='description';
  static const String DEPENSEJ ='depenseJ';
  static const String TOT ='tot';
  static const String DATE ='date';
  static const String TABLE ='Recette';
  static const String DB_NAME ='recette.db';

  Future<Database> get db async{
    if (_db != null ){
      return _db;
    }
    _db = await initDb();
        return _db;
  }
    
  initDb() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,DB_NAME);
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db,int version) async{
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $RECETTEJ INTEGER, $DEPENSEJ INTEGER, $DESCRIPTION TEXT, $TOT INTEGER, $DATE TEXT)");
  }
  Future<int> insertRecette(Recette recette) async{
    Database dbb = await this.db;
    var result = await dbb.insert(TABLE, recette.toMap());
    return result;
  }
  Future<int> updateRecette(Recette recette) async {
		var db = await this.db;
		var result = await db.update(TABLE, recette.toMap(), where: '$ID = ?', whereArgs: [recette.id]);
		return result;
	}

	Future<int> deleteRecette(int id) async {
		var db = await this.db;
		int result = await db.rawDelete('DELETE FROM $TABLE WHERE $ID = $id');
		return result;
	}
  Future<int> getCount() async {
		Database db = await this.db;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $TABLE');
		int result = Sqflite.firstIntValue(x);
		return result;
	}
  
  
}

