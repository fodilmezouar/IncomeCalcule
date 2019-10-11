import 'package:coffee_friends/sqlite/db_helper.dart';
import 'package:coffee_friends/sqlite/recette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'datePicker.dart';

class AddTachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showAlertDialog(String title, String message) {
      AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
    String newTaskTitle;
    DBHelper databaseHelper = DBHelper();
    TextEditingController dateController = TextEditingController();
    TextEditingController fraisController = TextEditingController();
    TextEditingController recetteController = TextEditingController();
    final format = DateFormat("yyyy-MM-dd");
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      color: Color(0xff2a1a5e),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Color(0xff2a1a5e),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            DateTimeField(
              controller: dateController,
              decoration: new InputDecoration(
                labelText: "Date:",
                labelStyle: TextStyle(fontSize: 19.0, color: Color(0xff2a1a5e)),
              ),
              textAlign: TextAlign.center,
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: fraisController,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: "Frais:",
                labelStyle: TextStyle(fontSize: 19.0, color: Color(0xff2a1a5e)),
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {},
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: recetteController,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: "Recette:",
                labelStyle: TextStyle(fontSize: 19.0, color: Color(0xff2a1a5e)),
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {},
            ),
            SizedBox(
              height: 40,
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(50.0),
              color: Color(0xff2a1a5e),
              child: FlatButton(
                child: Text(
                  'Ajouter',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (fraisController.text != "" &&
                      recetteController.text != "" &&
                      dateController.text != "") {
                    setState() {}
                    int frais = int.parse(fraisController.text);
                    int recette = int.parse(recetteController.text);
                    int tot = recette - frais;
                    print(tot);
                    Recette r =
                        new Recette(recette, frais, tot, dateController.text);
                    int result = 0;
                    result = await databaseHelper.insertRecette(r);
                    if (result != 0) {
                      // Success
                      _showAlertDialog('Status', 'Note Saved Successfully');
                      Navigator.pop(context);
                    } else {
                      // Failure
                      _showAlertDialog('Status', 'Problem Saving Note');
                    }
                    print(result);
                  }
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
    
  }
}
