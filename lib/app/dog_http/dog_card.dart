import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'dog_detail_page.dart';

class DogCard extends StatefulWidget {
  final Dog dog;

  DogCard(this.dog);

  @override
  _DogCardState createState() => _DogCardState(dog);
}

class _DogCardState extends State<DogCard> {
  Dog dog;
  String renderUrl;

  _DogCardState(this.dog);

  showDogDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DogDetailPage(dog);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showDogDetailPage,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: 570.0,
          height: 200.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 100.0,
                child: dogCard,
              ),
              Positioned(top: 15.0, child: dogImange),
            ],
          ),
        ),
      ),
    );
  }

  Widget get dogImange {
    var dogAvatar = Hero(
        tag: dog,
        
        child: Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: renderUrl == null
                    ? NetworkImage('https://via.placeholder.com/350x150')
                    : NetworkImage(renderUrl),
              )),
        ));

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black45, Colors.black, Colors.blueGrey[600]]),
      ),
      alignment: Alignment.center,
      child: Text(
        'DOGGO',
        textAlign: TextAlign.center,
      ),
    );

    return AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: dogAvatar,
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 2000),
    );
  }

  void initState() {
    super.initState();
    renderDogPic();
  }

  void renderDogPic() async {
    await dog.getImageUrl();
    setState(() {
      renderUrl = dog.imageUrl;
    });
  }

  Widget get dogCard {
    return Container(
      width: 500.0,
      height: 180.0,
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                widget.dog.name,
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
              Text(
                widget.dog.location,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star),
                  Text(
                    ': ${widget.dog.rating} / 10',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
