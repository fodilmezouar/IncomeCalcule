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
   
			updateListView();
      print(recetteList.length);
		}
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Colors.white,
        body: getNoteListView(),  
      ),
    );
  }
ListView getNoteListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

				

						title: Text(this.recetteList[position].recetteJ.toString(), style: titleStyle,),

						subtitle: Text(this.recetteList[position].date),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
						},

					),
				);
			},
		);
  }
  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initDb();
		dbFuture.then((database) {
      
			Future<List<Recette>> recetteListFuture = databaseHelper.getRecetteList();
			recetteListFuture.then((recetteList) {
		
				  this.recetteList = recetteList;
				  this.count = recetteList.length;
				print(this.recetteList.length);
			});
		});

  }
}