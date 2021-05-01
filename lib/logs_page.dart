import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

var Auth = FirebaseAuth.instance;
var user = Auth.currentUser.uid;

class Logs extends StatefulWidget {
  @override
  _LogsState createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Logs",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
            children: [

              Expanded(


                child: Padding(padding : EdgeInsets.all(18),
                  child: ClipRect(

                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightGreen[200],
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: StreamBuilder(
                          stream: FirebaseDatabase.instance.reference().child('User').child(user).child('Logs').onValue,
                          builder: (context, snap) {

                            if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {

                              print(snap.data.snapshot.value);
                              print("hi");
                              print(snap.data.snapshot.value.length);
                              List a= [];
                              int i=snap.data.snapshot.value.length;


                              for (
                              int j =0; j < snap.data.snapshot.value.length  ; j++) {
                                a.add(snap.data.snapshot.value["Crop${j+1}"]);
                                print("done");
                                print(a);
                              }

                              return ListView.builder( itemCount: a.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        // title: Text(item[index]['Message']),
                                        title: Text("---> " + a[index]
                                          , style: TextStyle(
                                            fontSize: 15,
                                          ),),

                                      ),
                                    );}
                              );
                            }
                            else
                              return Center(
                                child: Text("Loading Data Please Wait!!!!",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                              );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]));
  }
}