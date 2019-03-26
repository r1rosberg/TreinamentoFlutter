//https://fireship.io/lessons/flutter-slider-like-reflectly/

import 'package:flutter/material.dart';

class SlideShow extends StatefulWidget {
  @override
  SlideShowState createState() => SlideShowState();
}

class SlideShowState extends State<SlideShow> {
  final PageController pageCtrl = PageController(viewportFraction: 0.8);
  String activeTag;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    activeTag = 'Feliz';

    pageCtrl.addListener(() {
      int next = pageCtrl.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  List slideList = List();

  void _query({String tag = 'Favoritos'}) {
    setState(() {
      if (tag == 'Favoritos') {
        this.slideList = List()
        ..add('https://img.elo7.com.br/product/zoom/1C340F5/quadro-tela-paisagens-natureza-praia-coqueiro-mar-areia-004-quadro-tela.jpg')
        ..add('https://img.elo7.com.br/product/zoom/1C340E0/quadro-tela-paisagens-natureza-praia-coqueiro-mar-areia-003-quadro-tela.jpg')
        ..add('https://img.elo7.com.br/product/zoom/2302763/pintura-em-tela-quadro-moderno-promocao-praia.jpg');
      } else if (tag == 'Feliz') {
        this.slideList = List()
        ..add('https://img.elo7.com.br/product/zoom/CE3BF7/topo-de-bolo-debutante-topo-debutante.jpg');
      } else if (tag == 'Triste') {
        this.slideList = List()
        ..add('https://img.elo7.com.br/product/zoom/12B9436/rede-de-dormir-casal-clone-var-macrame-redes-de-descanso.jpg')
        ..add('https://img.elo7.com.br/product/zoom/18E1772/quadro-a-beira-da-praia-pintado-a-mao.jpg');
      }
    });
    activeTag = tag;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: PageView(
        controller: pageCtrl,
        children: <Widget>[
          _buildTagPage(),
          _buildStoryPage(1 == currentPage),
          _buildStoryPage(2 == currentPage),
          _buildStoryPage(3 == currentPage),
        ],*/

      body: PageView.builder(
          controller: pageCtrl,
          itemCount: slideList.length + 1,
          itemBuilder: (context, int currentIdx) {
            if (currentIdx == 0) {
              return _buildTagPage();
            } else if (slideList.length >= currentIdx) {
              // Active page
              bool active = currentIdx == currentPage;
              return _buildStoryPage(slideList[currentIdx -1], active);
            }
          }),
      /*body: PageView.builder(
        controller: pageCtrl,
        itemCount: teste.length + 1,
        itemBuilder: (context, int currentIdx) {
          if (currentIdx == 0) {
            return _buildTagPage();
          } else if (teste.length >= currentIdx) {
            bool active = currentIdx == currentPage;
            return _buildStoryPage(active);
          }
        },
      ),*/
    );
  }

  Widget _buildStoryPage(String url, bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amber,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(url),
                //'https://via.placeholder.com/500/0000FF/808080 ?Text=Digital.com)'),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black87,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]),
    );
  }

  Widget _buildTagPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Seu Histórico',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          Text('Filtro', style: TextStyle(color: Colors.black26)),
          _buildButton('Favoritos'),
          _buildButton('Feliz'),
          _buildButton('Triste'),
        ],
      ),
    );
  }

  Widget _buildButton(tag) {
    Color color = tag == activeTag ? Colors.purple : Colors.white;
    return FlatButton(
      color: color,
      child: Text('#$tag'),
      onPressed: () => _query(tag: tag),
    );
  }
}
