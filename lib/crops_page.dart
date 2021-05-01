import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

var Auth = FirebaseAuth.instance;

var uid = Auth.currentUser.uid;

class Crop extends StatefulWidget {
// HomePage({Key key, this.auth, this.userId, this.logoutCallback})
//     : super(key: key);

// final BaseAuth auth;
// final VoidCallback logoutCallback;
// final String userId;

  @override
  _CropState createState() => new _CropState();
}

class _CropState extends State<Crop> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  final _moistureEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

//bool _isEmailVerified = false;
  int selectedRadioTile = 1;
  setSelectedRadioTile(int val) {
    setState(() {
      FirebaseDatabase.instance
          .reference()
          .child("User")
          .child(uid)
          .child('Crops')
          .update({
        'activeCrop': val,
      });

      FirebaseDatabase.instance
          .reference()
          .child("User")
          .child(uid)
          .child('Crops')
          .child(val.toString())
          .once()
          .then((DataSnapshot snapshot) {
        print(snapshot);
        print(snapshot.value['name']);
        print(snapshot.value['humidity']);
        print("Done");
      });

      selectedRadioTile = val;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child("User")
        .child(uid)
        .child('Crops')
        .once()
        .then((DataSnapshot snapshot) {
      selectedRadioTile = snapshot.value['activeCrop'];
      print(selectedRadioTile);
    });

    _todoList = new List();
    _todoQuery = _database.reference().child("User").child(uid).child("Crops");
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Todo.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  }

  addNewTodo(String todoItem) {
    if (todoItem.length > 0) {
      int id;
      FirebaseDatabase.instance
          .reference()
          .child("User")
          .child(uid)
          .child('Crops')
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          FirebaseDatabase.instance
              .reference()
              .child("User")
              .child(uid)
              .child('Crops')
              .set({'noOfCrops': 0, 'activeCrop': 0, 'activeHumidity': 0});
          id = snapshot.value['noOfCrops'] + 1;
          FirebaseDatabase.instance
              .reference()
              .child("User")
              .child(uid)
              .child('Crops')
              .update({
            'noOfCrops': id,
          });
          Todo todo = new Todo(todoItem.toString(), id, 45);
          _database
              .reference()
              .child("User")
              .child(uid)
              .child("Crops")
              .child(id.toString())
              .set(todo.toJson());
        } else {
          FirebaseDatabase.instance
              .reference()
              .child("User")
              .child(uid)
              .child('Crops')
              .once()
              .then((DataSnapshot snapshot) {
            print('Data : ${snapshot.value['noOfCrops']}');
            id = snapshot.value['noOfCrops'] + 1;
            print(id);
            FirebaseDatabase.instance
                .reference()
                .child("User")
                .child(uid)
                .child('Crops')
                .update({
              'noOfCrops': id,
            });
            Todo todo = new Todo(todoItem.toString(), id, 45);
            _database
                .reference()
                .child("User")
                .child(uid)
                .child("Crops")
                .child(id.toString())
                .set(todo.toJson());
          });
        }
      });
    }
  }

  deleteTodo(String todoId, int index) {
    _database
        .reference()
        .child("User")
        .child(uid)
        .child("Crop")
        .child(todoId)
        .remove()
        .then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }

  showAddTodoDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new crop',
                  ),
                )),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  updateMoisture(String moisture, todoId) {
    var moist = int.parse(moisture);
    print(moist);
    FirebaseDatabase().reference().child("User")
      ..child(uid).child('Crops').child(todoId).update({'humidity': moist});
  }

  showMoistureChanger(BuildContext context, String todoId) async {
    _moistureEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  controller: _moistureEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Enter the updated moisture',
                  ),
                )),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    updateMoisture(
                        _moistureEditingController.text.toString(), todoId);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  Widget showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String name = _todoList[index].name;
            int id = _todoList[index].id;
            int humidity = _todoList[index].humidity;

            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                deleteTodo(todoId, index);
              },
              child: RadioListTile(
                groupValue: selectedRadioTile,
                value: id,
                title: Text(
                  name,
                  style: TextStyle(fontSize: 20.0),
                ),
                secondary: OutlineButton(
                  child: Text(humidity.toString() + " % Moisture"),
                  onPressed: () {
                    showMoistureChanger(context, todoId);
                    print("Say Hello ");
                  },
                ),
                activeColor: Colors.blue[600],
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setSelectedRadioTile(val);
                },
                selected: false,
// trailing: IconButton(
//     icon: (id)
//         ? Icon(
//       Icons.done_outline,
//       color: Colors.green,
//       size: 20.0,
//     )
//         : Icon(Icons.done, color: Colors.grey, size: 20.0),
//     onPressed: () {
//       updateTodo(_todoList[index]);
//     }),
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        "Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Crops'),
        ),
        body: showTodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTodoDialog(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}

class Todo {
  String key;
  String name;
  int humidity;
  int id;

  Todo(this.name, this.id, this.humidity);

  Todo.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        id = snapshot.value["id"],
        humidity = snapshot.value["humidity"];
  toJson() {
    return {"name": name, "id": id, "humidity": humidity};
  }
}
