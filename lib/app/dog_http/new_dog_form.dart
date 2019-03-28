import 'package:flutter/material.dart';
import 'dog_model.dart';

class AddDogFromPage extends StatefulWidget {
  @override
  _AddDogFromPageState createState() => _AddDogFromPageState();
}

class _AddDogFromPageState extends State<AddDogFromPage> {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Inserindo um novo Cão...', style: TextStyle(fontSize: 30.0)),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Nome do Cão:'),
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: locationController,
                    decoration:
                        InputDecoration(labelText: 'Localização do Cão:'),
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Tudo sobre o Cão:'),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return RaisedButton(
                      onPressed: () => _submitPup(context),
                      color: Colors.indigoAccent,
                      child: Text('Salvar Cão...'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Preenche o nome!!')));
    } else {
      Dog newDog = new Dog(this.nameController.text,
          this.locationController.text, this.descriptionController.text);
      Navigator.of(context).pop(newDog);
    }
  }
}
