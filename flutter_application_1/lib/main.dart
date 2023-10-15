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
  String current = positiveMessages[0];

  void getNext() {
    Random random = Random();

    int randomIndex = random.nextInt(positiveMessages.length);

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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/1200x/3e/ed/46/3eed464cf4d50417eb127982b8dc7c35.jpg'), // Replace with your online image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 20, // Adjust the position as needed
            left: 0, // Adjust the position as needed
            child: IconButton(
              icon: Icon(
                Icons.swap_calls_outlined,
                color: Colors.white,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "",
        ),
        Center(
          child: Text(
            appState.current,
            style: TextStyle(
              fontSize: 36.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                    appState.favorites.contains(appState.current)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                    size: 36.0),
                onPressed: () {
                  appState.toggleFavorite();
                },
              ),
              IconButton(
                icon: Icon(Icons.navigate_next_outlined,
                    color: Colors.white, size: 36.0),
                onPressed: () {
                  appState.getNext();
                },
              ),
              IconButton(
                icon: Icon(Icons.play_circle_outline,
                    color: Colors.white, size: 36.0),
                onPressed: () {
                  speakText(appState.current);
                },
              ),
            ],
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
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
                'You have '
                '${appState.favorites.length} favorites:',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold)),
          ),
          for (var pair in appState.favorites)
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(0), // Adjust the padding as needed
                    ),
                  ),
                  onPressed: () {
                    // Add your button click logic here
                    appState.current = pair;
                  },
                  child: Text(pair)),
            ),
        ],
      ),
    );
  }
}
