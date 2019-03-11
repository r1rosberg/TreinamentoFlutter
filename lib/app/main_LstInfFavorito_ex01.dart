import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//void main() => runApp(new MyApp());

class LstInfFavorito_ex01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Bem vindo ao Flutter',
      home: new RandomWords(),
      theme: new ThemeData.dark(),
      /*home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Bem vindo ao Flutter'),
          ),
          body: new Center(
            child: RandomWords(),
            //child: new Text(wordPair.asPascalCase),
            //child: const Text('Olá Mundo'),
          ),
        )*/
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random();
    //return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Bem vindo ao Flutter'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              size: 38.0,
            ),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return new Scaffold(
          appBar: new AppBar(
            title: const Text('Favoritos salvos'),
          ),
          body: new ListView(
            children: divided,
          ));
    }));
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return new Divider();
          }

          final int index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySave = this._saved.contains(pair);
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          alreadySave ? Icons.favorite : Icons.favorite_border,
          color: alreadySave ? Colors.red : Colors.blue,
        ),
        onTap: () {
          setState(() {
            if (alreadySave) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
