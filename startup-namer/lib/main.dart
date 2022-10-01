import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    final wordPair=WordPair.random();
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Startup Name Generator",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
        )
      ),
      home: RandomWords(),
        
    );
  }

}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  final _sugestions=<WordPair>[];
  final _biggerFont=const TextStyle(fontSize: 18);
  final _saved=<WordPair>{};

    void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }
  @override
  Widget build(BuildContext context) {

    final wordpair=WordPair.random();



    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Name Generator"),
        actions: [
          IconButton(
            onPressed: _pushSaved, 
            icon: const Icon(Icons.list),
            tooltip: 'Saved sugestions',
            )
        ],
      ),
      body:ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _sugestions.length) {
          _sugestions.addAll(generateWordPairs().take(10));
        }
        final alreadySaved=_saved.contains(_sugestions[index]);
        return ListTile(
          leading:const Icon(Icons.wallet_membership_outlined),
          
          title: Text(
            _sugestions[index].asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            alreadySaved? Icons.favorite : Icons.favorite_border,
            
            color: alreadySaved? Colors.red : null,
            semanticLabel: alreadySaved? 'Remove from saved' : "save",
          ),
          onTap: (){
            setState(() {
              if(alreadySaved){
                _saved.remove(_sugestions[index]);
              }else{
                _saved.add(_sugestions[index]);
                print(alreadySaved);
              }
            });
          },
        );
      },
      )
    );
    
    
    
    
    
  }
}