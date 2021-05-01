import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:agriculture_assistance/API.dart';
import 'dart:convert';
import 'package:truncate/truncate.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  DateTime dateTime = DateTime.now();
  String url;
  var Data;
  var QueryText = " - ";
  var QueryText2 = " - ";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Predictor"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDatePicker(),
            const SizedBox(height: 24),
            RaisedButton(
                child: Text(
                  "Predict Temperature",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue[600],
                onPressed: () async {
                  print("Working");
                  final value = DateFormat('yyyy-MM-dd').format(dateTime);
                  print(value);
                  url =
                      'https://agriculture-assistance.herokuapp.com/predict?Query=' +
                          value.toString();
                  Data = await Getdata(url);
                  var DecodedData = jsonDecode(Data);
                  setState(() {
                    QueryText =
                        truncator(DecodedData['Max_temp'], 5, CutStrategy());
                    QueryText2 =
                        truncator(DecodedData['Min_temp'], 5, CutStrategy());
                    print("Finalllllllllllllllllll");
                    print(QueryText);
                  });
                }),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(5, 5, 5, .5),
                      blurRadius: 20,
                      offset: Offset(0, 7))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Max Temp : " + QueryText + " °C",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700]),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(5, 5, 5, .5),
                      blurRadius: 20,
                      offset: Offset(0, 7))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Min Temp : " + QueryText2 + " °C",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          minimumYear: 2015,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
}
