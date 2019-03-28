/**
 * https://flutterbyexample.com/basic-dogs-app-setup
 * Flutter por exemplo
 * Configuração básica do aplicativo Dogs
 */
import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'dog_list.dart';
import 'new_dog_form.dart';

class DogMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nós Classificamos Cães",
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: "Nós Classificamos Cães"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Dog> initialDoggos = []
    ..add(Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'))
    ..add(Dog('Rod Stewart', 'Prague, CZ',
        'Star good boy on international snooze team.'))
    ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(Dog('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showNewDogFrom,)
        ],
      ),
      body: Container(
        child: DogList(initialDoggos),//DogDetailPage(initialDoggos[1]),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.5,
                0.7,
                0.9
              ],
              colors: [
                Colors.indigo[800],
                Colors.indigo[700],
                Colors.indigo[600],
                Colors.indigo[400],
              ]),
        ),
      ),
    );
  }

  Future _showNewDogFrom() async{
    Dog newDog =await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AddDogFromPage();
        }
      ),
    );

    if (newDog != null) {
      setState(() {
        initialDoggos.add(newDog);
      });      
    }
  }
}
