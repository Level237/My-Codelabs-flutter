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
    return MaterialApp(
      title: "Startup Name Generator",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Startup Name Generator") ,
        ),
        body: const Center(
          child: RandomWords(),
          ),
        ),
        
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
  @override
  Widget build(BuildContext context) {

    final wordpair=WordPair.random();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _sugestions.length) {
          _sugestions.addAll(generateWordPairs().take(10));
        }
        return ListTile(
          title: Text(
            _sugestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
  }
}