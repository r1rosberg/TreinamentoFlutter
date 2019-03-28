//import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Dog {
  String name;
  String location;
  String description;
  String imageUrl;
  //Todos os cães começam com 10, porque são bons cães.
  int rating = 10;

  //static String defaultUrl = 'https://via.placeholder.com/350x150';

  Dog(this.name, this.location, this.description) {
    //this.imageUrl = defaultUrl;
    //getImageUrl();
  }

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {
      var uri = Uri.http('dog.ceo', '/api/breeds/image/random');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      this.imageUrl = json.decode(responseBody)['message'];
      //print(imageUrl);
    } catch (exception) {
      print(exception);
    }
  }
}
