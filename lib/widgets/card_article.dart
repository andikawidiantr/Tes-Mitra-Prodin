import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../main.dart';
import '../model/person.dart';

class CardArticle extends StatelessWidget {
  final Result result;

  const CardArticle({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    int rank;
    // List<Person> adultUsers = result.where((result) => result.name > 18).toList();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
                  child: Text(
                    result.namePerson,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Text(
                    result.name,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(20.0, 6.0, 6.0, 12.0),
                  child: Text(
                    result.point.toString(),
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
               Padding(
                 padding: EdgeInsets.all(8.0),
                 child: GestureDetector(
                   onTap: () {
                     showAlertDialog(context,result.rank);
                     print('ke klik kok');
                   },
                 child: const Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: <Widget>[
                     Padding(
                       // child: const Text('Delete Data'),
                         padding: EdgeInsets.all(8.0),
                         child: Icon(
                           Icons.delete,
                           size: 35.0,
                           color: Colors.grey,
                         ),
                     ),
                   ],
                 ),
               )
               ),
          ],
        ),
        const Divider(
          height: 2.0,
          color: Colors.grey,
        )
      ],
    );
  }
}
// Show AlertDialog
showAlertDialog(BuildContext context,int rank) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: const Text('Delete Data?'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel',
            style: TextStyle(color : Colors.blueAccent)),
      ),
      TextButton(
        onPressed: () {
          ApiService().deletePerson(rank);
          // Navigator.pop(context);
          // var route = MaterialPageRoute(
          //   builder: (BuildContext context) =>  main(),
          // );
          // Navigator.of(context).push(route);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=>MyApp())), (route) => false);
        },
        child: const Text('OK',
          style: TextStyle(color : Colors.blueAccent)
        ),
      ),
    ],
  );
  // Show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print('cancel klik kok');
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                print('ok klik kok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}


