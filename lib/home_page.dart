import 'package:agriculture_assistance/setting_page.dart';
import 'package:agriculture_assistance/weather_page.dart';
import 'authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agriculture_assistance/Crops_page.dart';
import 'package:agriculture_assistance/logs_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

var Auth = FirebaseAuth.instance;

var user = Auth.currentUser.uid;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      print("pressed");
                      context.read<AuthenticationProvider>().signOut();
                    },
                    child: Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.brown[700],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(5, 5, 5, .5),
                          blurRadius: 20,
                          offset: Offset(0, 7))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(5, 5, 5, .5),
                              blurRadius: 20,
                              offset: Offset(0, 7))
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: 70,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(20),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Color.fromRGBO(5, 5, 5, .5),
//                                      blurRadius: 20,
//                                      offset: Offset(0, 7))
//                                ]),

                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Temperature :",
                                        style: TextStyle(
                                            color: Colors.blueGrey[900],
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(children: [
                                    Container(
                                      color: Colors.white,
                                      child: StreamBuilder(
                                          stream: FirebaseDatabase.instance
                                              .reference()
                                              .child('User')
                                              .child(user)
                                              .child('DHT11')
                                              .onValue,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                !snapshot.hasError &&
                                                snapshot.data.snapshot.value !=
                                                    null) {
                                              print(
                                                  snapshot.data.snapshot.value);

                                              // var data = snapshot.data.snapshot.value;

                                              return Text(
                                                snapshot.data.snapshot
                                                    .value['Temperature'],
                                                style: TextStyle(
                                                    color: Colors.blueGrey[900],
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.start,
                                              );
                                            } else {
                                              return CircularProgressIndicator(
                                                backgroundColor: Colors.blue,
                                              );
                                            }
                                          }),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Humidity :",
                                        style: TextStyle(
                                            color: Colors.blueGrey[900],
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(children: [
                                    Container(
                                      color: Colors.white,
                                      child: StreamBuilder(
                                          stream: FirebaseDatabase.instance
                                              .reference()
                                              .child('User')
                                              .child(user)
                                              .child('DHT11')
                                              .onValue,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                !snapshot.hasError &&
                                                snapshot.data.snapshot.value !=
                                                    null) {
                                              print(
                                                  snapshot.data.snapshot.value);
                                              return Text(
                                                snapshot.data.snapshot
                                                    .value['Humidity'],
                                                style: TextStyle(
                                                    color: Colors.blueGrey[900],
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.start,
                                              );
                                            } else {
                                              return CircularProgressIndicator(
                                                backgroundColor: Colors.blue,
                                              );
                                            }
                                          }),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20.0,
                  children: <Widget>[
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Crop()));
                        },
                        child: Card(
                          color: Colors.lightBlue[50],
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/grain.png",
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Crops",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Logs()));
                          print("pressed");
                        },
                        child: Card(
                          color: Colors.lightBlue[50],
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/note.png",
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Logs",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => WeatherPage()));
                          print("pressed");
                        },
                        child: Card(
                          color: Colors.lightBlue[50],
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/weather.png",
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Weather",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: GestureDetector(
                        onTap: () {
                          print("pressed");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SettingFragment()));
                        },
                        child: Card(
                          color: Colors.lightBlue[50],
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/settings.png",
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
