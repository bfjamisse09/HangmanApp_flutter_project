import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const HangmanApp());
}

class HangmanApp extends StatelessWidget {
  const HangmanApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Hangman App - Akenathon Furtado'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _words = [
    'COMPUTAÇÃO',
    'FLUTTER',
    'UESPI',
    'PROGRAMA',
    'HUMANO'
  ];

   final List<String> _hangmanImages = [
    'assets/images/Hangman-0.png', // No incorrect guesses
    'assets/images/Hangman-1.png', // 1 incorrect guess
    'assets/images/Hangman-2.png', // ...
    'assets/images/Hangman-3.png',
    'assets/images/Hangman-4.png',
    'assets/images/Hangman-5.png',
    'assets/images/Hangman-6.png', // Game over
  ];
  String _wordToGuess = '';
  List<String> _guessedLetters = [];
  int _incorrectGuesses = 0;
  static const int _maxGuesses = 6;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    _wordToGuess = _words[Random().nextInt(_words.length)];
    _guessedLetters = [];
    _incorrectGuesses = 0;
  }

  void _guessLetter(String letter) {
    if (_guessedLetters.contains(letter) || _incorrectGuesses >= _maxGuesses) {
      return;
    }

    setState(() {
      _guessedLetters.add(letter);

      if (!_wordToGuess.contains(letter)) {
        _incorrectGuesses++;
      }
    });
  }

  bool _isGameOver() {
    return _incorrectGuesses >= _maxGuesses || _isWordGuessed();
  }

  bool _isWordGuessed() {
    for (int i = 0; i < _wordToGuess.length; i++) {
      if (!_guessedLetters.contains(_wordToGuess[i])) {
        return false;
      }
    }
    return true;
  }

  Widget _buildWordDisplay() {
    List<Text> wordDisplay = [];
    for (int i = 0; i < _wordToGuess.length; i++) {
      if (_guessedLetters.contains(_wordToGuess[i])) {
        wordDisplay.add(
          Text(
            _wordToGuess[i],
            style: TextStyle(fontSize: 32),
          ),
        );
      } else {
        wordDisplay.add(
          Text(
            'X',
            style: TextStyle(fontSize: 36),
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: wordDisplay,
    );
  }

  Widget _buildHangmanImage() {
    // Use the current number of incorrect guesses to select the image
    String currentImage = _hangmanImages[_incorrectGuesses];
    return Image.asset(
      currentImage,
      width: 200,
      height: 200,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tentativas Incorretas: $_incorrectGuesses/$_maxGuesses',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                child: _buildHangmanImage(),
            ),
            _buildWordDisplay(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _guessLetter('Q'),
                      child: const Text('Q'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('W'),
                      child: const Text('W'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('E'),
                      child: const Text('E'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('R'),
                      child: const Text('R'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('T'),
                      child: const Text('T'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('Y'),
                      child: const Text('Y'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('U'),
                      child: const Text('U'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('I'),
                      child: const Text('I'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('O'),
                      child: const Text('O'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('P'),
                      child: const Text('P'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _guessLetter('A'),
                      child: const Text('A'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('S'),
                      child: const Text('S'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('D'),
                      child: const Text('D'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('F'),
                      child: const Text('F'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('G'),
                      child: const Text('G'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('H'),
                      child: const Text('H'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('J'),
                      child: const Text('J'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('K'),
                      child: const Text('K'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('L'),
                      child: const Text('L'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _guessLetter('Z'),
                      child: const Text('Z'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('X'),
                      child: const Text('X'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('C'),
                      child: const Text('C'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('V'),
                      child: const Text('V'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('B'),
                      child: const Text('B'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('N'),
                      child: const Text('N'),
                    ),
                    ElevatedButton(
                      onPressed: () => _guessLetter('M'),
                      child: const Text('M'),
                    ),
                  ],
                ),
              ],
            ),
            if (_isGameOver())
              Text(
                _isWordGuessed() ? 'Acertou!' : 'Perdeu! A Palavra era $_wordToGuess',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
