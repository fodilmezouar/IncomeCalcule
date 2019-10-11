import 'package:coffee_friends/sqlite/db_helper.dart';
import 'package:coffee_friends/sqlite/recette.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ListeTaches extends StatefulWidget {
  @override
  _ListeTachesState createState() => _ListeTachesState();
}

class _ListeTachesState extends State<ListeTaches> {
  DBHelper databaseHelper = DBHelper();
  List<Recette> recetteList;
  int count =0;
  @override
  Widget build(BuildContext context) {
    if (recetteList == null) {
			recetteList = List<Recette>();
      Future<List<Recette>> recetteListFuture = databaseHelper.getRecetteList();
   
		//	updateListView();
		}
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Colors.white,  
      ),
    );
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initDb();
		dbFuture.then((database) {

			Future<List<Recette>> recetteListFuture = databaseHelper.getRecetteList();
			recetteListFuture.then((recetteList) {
				setState(() {
				  this.recetteList = recetteList;
				  this.count = recetteList.length;
				});
			});
		});
  }
}