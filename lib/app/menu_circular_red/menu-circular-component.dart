import 'package:flutter/material.dart';

import './dialogonal-clipper.dart';
import './task.dart';
import './task-row.dart';
import './list-model.dart';
import './animated-fab.dart';

class MenuCircularComponent {
  double imageHeight = 256.0;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  ListModel listModel;
  bool showOnlyCompleted = false;

  List<Task> tasks = [
    Task(
        name: "1- Catch up with Brian",
        category: "Mobile Project",
        time: "5pm",
        color: Colors.orange,
        completed: false),
    Task(
        name: "2- Make new icons",
        category: "Web App",
        time: "3pm",
        color: Colors.cyan,
        completed: true),
    Task(
        name: "3- Design explorations",
        category: "Company Website",
        time: "2pm",
        color: Colors.pink,
        completed: false),
    Task(
        name: "4- Lunch with Mary",
        category: "Grill House",
        time: "12pm",
        color: Colors.cyan,
        completed: true),
    Task(
        name: "5- Teem Meeting",
        category: "Hangouts",
        time: "10am",
        color: Colors.cyan,
        completed: true),
    Task(
        name: "6- Catch up with Brian",
        category: "Mobile Project",
        time: "5pm",
        color: Colors.orange,
        completed: false),
    Task(
        name: "7- Make new icons",
        category: "Web App",
        time: "3pm",
        color: Colors.cyan,
        completed: true),
    Task(
        name: "8- Design explorations",
        category: "Company Website",
        time: "2pm",
        color: Colors.pink,
        completed: false),
    Task(
        name: "9- Lunch with Mary",
        category: "Grill House",
        time: "12pm",
        color: Colors.cyan,
        completed: true),
    Task(
        name: "10- Teem Meeting",
        category: "Hangouts",
        time: "10am",
        color: Colors.cyan,
        completed: true),
  ];

  Widget buildImage() {
    return ClipPath(
      clipper: DialogonalClipper(),
      child: Container(
        color: Colors.blue,
        child: Image.asset(
          'images/bird.jpg',
          fit: BoxFit.cover,
          height: imageHeight,
          width: double.maxFinite,
          colorBlendMode: BlendMode.srcOver,
          color: Color.fromARGB(120, 20, 10, 40),
        ),
      ),
    );
  }

  Widget buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu, size: 32.0, color: Colors.white),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Lista de Compra',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Icon(Icons.linear_scale, size: 32.0, color: Colors.white),
        ],
      ),
    );
  }

  Widget buildProfileRow() {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: imageHeight * 0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              minRadius: 28.0,
              maxRadius: 28.0,
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/a-/AAuE7mApGc6O4xyaYw6cuIpM5bTpAckkdreFVpfwPwk_=s96'),
            ),
          ),
          //Spacer(),
          //VerticalDivider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Rosberg Fernander Soares',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Desenvolvedor',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildBottomPart() {
    return Padding(
      padding: EdgeInsets.only(top: imageHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildMyTasksHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Minhas Tarefas',
            style: TextStyle(fontSize: 34.0),
          ),
          Text(
            '22 de Março de 2019',
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buidTimeLine() {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  /*Widget _buildTasksList() {
    return Container(
      child: ListView(
        children: Task().Lista().map((task) => TaskRow(task: task)).toList(),
      ),
    );
  }*/

  Widget _buildTasksList() {
    return Expanded(
      child: AnimatedList(
        initialItemCount: tasks.length,
        key: listKey,
        itemBuilder: (context, index, animation) {
          return TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget buidFab() {
    return Positioned(
      top: imageHeight - 100.0,
      right: -40.0,
      child: AnimatedFab(
        onClick: _changeFilterState,
      ),
    );
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    //List<Task> auxLista;
    //auxLista =
    tasks.where((task) => task.completed == false).forEach((task) {
      print(task.toString());

      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(listModel.indexOf(task), task);
      }
    });

    /*for (var task in auxLista) {
      print(task.toString());
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(listModel.indexOf(task), task);
      }
    }*/
  }
}
