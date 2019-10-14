import 'package:coffee_friends/home_present.dart';
import 'package:coffee_friends/recette_liste.dart';
import 'package:coffee_friends/sqlite/db_helper.dart';
import 'package:coffee_friends/sqlite/recette.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ListeTaches extends StatefulWidget {
  ListeTaches();
  @override
  _ListeTachesState createState() => _ListeTachesState();
}

class _ListeTachesState extends State<ListeTaches> implements HomeContract {
  DBHelper databaseHelper = DBHelper();
  HomePresenter homePresenter;

  @override
  void initState() {
    super.initState();
    homePresenter = new HomePresenter(this);
    
  }

  List<Recette> recetteList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (recetteList == null) {
      recetteList = List<Recette>();

      updateListView();
    }
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xff2a1a5e)),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(title: Text("Listed des taches"),
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        )),

        body:Container(
          padding: EdgeInsets.only(top: 10.0),
          child:  new FutureBuilder<List<Recette>>(
            future: databaseHelper.getRecetteList(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new RecetteListe(recetteList, homePresenter)
                  : new Center(child: new CircularProgressIndicator());
            }),
        )
      ),
    );
  }

  

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initDb();
    dbFuture.then((database) {
      Future<List<Recette>> recetteListFuture = databaseHelper.getRecetteList();
      recetteListFuture.then((recetteList) {
        this.recetteList = recetteList;
        this.count = recetteList.length;
      });
    });
  }

  @override
  void screenUpdate() {
    setState(() {
      updateListView();
    });
  }
}
