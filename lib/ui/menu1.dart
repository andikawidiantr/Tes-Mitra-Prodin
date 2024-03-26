import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_service.dart';
import '../main.dart';

class menu1 extends StatefulWidget {
  const menu1({Key? key}) : super(key: key);

  @override
  _Menu2State createState() => _Menu2State();
  static const String menuTitle = 'Menu 1';
}

class _Menu2State extends State<menu1> {

  final _formKey = GlobalKey<FormState>();

  List categoryItemlist = [];

  Future getAllCity() async {
    var baseUrl = "http://10.0.2.2:8000/api/city";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCity();
  }

  var dropdownvalue;

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerPoint = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("DropDown List"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0,20.0,30.0,20.0),
        child: ListView(
          children: <Widget>[

            Column(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: controllerName,

                          decoration: const InputDecoration(
                              hintText: "Nama", labelText: "Nama"),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField(
                          // hint: Text('hooseNumber'),
                          padding: const EdgeInsets.fromLTRB(0,20.0,0,20.0),
                          decoration: InputDecoration(
                            hintText: "City",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                          items: categoryItemlist.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['name'].toString()),
                            );
                          }).toList(),
                          validator: (value) => value == null ? "Select a country" : null,
                          value: dropdownvalue,
                          onChanged: (newVal) {
                              dropdownvalue = newVal;
                          },
                        ),
                        TextFormField(
                          controller: controllerPoint,
                          keyboardType:TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "Point", labelText: "Point"),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty || !RegExp(r'^[1-9]?[0-9]{1}$|^100$').hasMatch(value)) {
                              return 'Please enter Point 1-100';
                            }
                            return null;
                          },
                        ),

                      ],
                    )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ApiService().createPerson(controllerName.text,dropdownvalue.toString(),controllerPoint.text );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            // addData();
                            return MyApp();
                          }),
                        );
                      }
                    },
                    child: Text('Add Data'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
