import 'dart:collection';

import 'package:flutter/material.dart';
import 'listAll.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

FlutterTts flutterTts = FlutterTts();

Future<void> configureTts() async {
  await flutterTts.setLanguage('en-US');
  await flutterTts.setSpeechRate(1.0);
  await flutterTts.setVolume(1.0);
}

void speakText(String text) async {
  await flutterTts.speak(text);
}

void stopSpeaking() async {
  await flutterTts.stop();
}

Color lighten(Color c) {
    final hsl = HSLColor.fromColor(c);
    var hslLight = hsl.withLightness((hsl.lightness + 0.5).clamp(0.0, 0.95));
    hslLight = hslLight.withSaturation((hsl.saturation + 0.5).clamp(0.0, 0.99));
    return hslLight.toColor();
}

Color randomPrimary() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var favorites = [];
  var favoriteColor = [];
  String current = positiveMessages[0];
  Color currColor = Colors.deepOrangeAccent;
  Color fillColor = lighten(Colors.deepOrangeAccent);

  void getNext() {
    Random random = Random();

    int randomIndex = random.nextInt(positiveMessages.length);

    currColor = randomPrimary();
    fillColor = lighten(currColor);
    current = positiveMessages[randomIndex];
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _page = true;

  @override
  Widget build(BuildContext context) {
    var selectedPage = _page ? GenPage() : LikePage();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 20, // Adjust the position as needed
            left: 0, // Adjust the position as needed
            child: IconButton(
              icon: Icon(
                Icons.swap_calls_outlined,
                color: Colors.black,
                size: 48.0, // Adjust the size as needed
              ),
              onPressed: () {
                setState(() {
                  _page = !_page;
                });
              },
            ),
          ),
          selectedPage,
        ],
      ),
    );
  }
}

class GenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "",
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: appState.fillColor,
              border: Border.all(
                color: appState.currColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: SizedBox(
              width: 300,
              height: 500,
              child: Center(
                child: SizedBox(
                  width: 260,
                  child: Text(
                    appState.current,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: appState.currColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container (
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                      appState.favorites.contains(appState.current)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.black,
                      size: 60.0),
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.navigate_next_outlined,
                      color: Colors.black, size: 60.0),
                  onPressed: () {
                    appState.getNext();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_circle_outline,
                      color: Colors.black, size: 60.0),
                  onPressed: () {
                    speakText(appState.current);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LikePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: ListView(
        itemExtent: 50.0,
        children: [
          Container (
            child: Center(
              child: Text(
                'My favorited affirmations:',
                style: TextStyle(
                  fontSize: 27,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          for (var pair in appState.favorites)
            FaveTile(appState: appState, pair: pair),
        ],
      ),
    );
  }
}

class FaveTile extends StatelessWidget {
  FaveTile({
    super.key,
    required this.appState,
    required this.pair,
  });

  final MyAppState appState;
  final pair;
  Color tileColor = randomPrimary();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: tileColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
          color: lighten(tileColor),
        ),
        child: SizedBox(
          width: 10,
          height: 40,
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(0), // Adjust the padding as needed
              ),
            ),
            onPressed: () {
              // Add your button click logic here
              appState.current = pair;
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage()));
            },
            child: Text(
              pair,
              style: TextStyle(
                color: tileColor,
              ),
            )
          ),
        ),
      ),
    );
  }
}
