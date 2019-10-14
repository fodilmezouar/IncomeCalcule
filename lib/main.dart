import 'package:coffee_friends/add_tach_screen.dart';
import 'package:coffee_friends/filter_income.dart';
import 'package:flutter/material.dart';
import 'listeTaches.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
      theme: ThemeData(primaryColor: Color(0xff2a1a5e)),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void navigateToListe() async {
      bool result =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ListeTaches();
      }));

      if (result == true) {
        print("object");
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
              context: context, builder: (context) => new AddTachScreen());
        },
        backgroundColor: Color(0xff2a1a5e),
        child: Icon(Icons.note_add),
      ),
      appBar: AppBar(
        title: Text("Cafee des amis"),
      ),
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(50.0),
                  color: Color(0xff2a1a5e),
                  child: MaterialButton(
                      onPressed: navigateToListe,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.view_list,
                            color: Color(0xfff5f0e3),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Listes des taches",
                            style: new TextStyle(
                                color: Color(0xfff5f0e3), fontSize: 22.0),
                          ),
                        ],
                      )),
                )),
            SizedBox(
              height: 50,
            ),
            Container(
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(50.0),
                  color: Color(0xff2a1a5e),
                  child: MaterialButton(
                      onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return FilterIncome();
                          })),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                            color: Color(0xfff5f0e3),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Chiffre du jour",
                            style: new TextStyle(
                                color: Color(0xfff5f0e3), fontSize: 22.0),
                          ),
                        ],
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
