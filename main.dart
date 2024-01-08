import 'package:flutter/material.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Tic Tac Toe'),
    );
 }
}

class MyHomePage extends StatefulWidget {
 const MyHomePage({Key? key, required this.title}) : super(key: key);

 final String title;

 @override
 State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 List<String> board = List.generate(9, (index) => '');
 String currentPlayer = 'X';
 bool isGameOver = false;

 void onTileTapped(int index) {
    if (isGameOver || board[index] != '') return;
    setState(() {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      isGameOver = checkGameOver();
    });
 }

 bool checkGameOver() {
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        return true;
      }
      if (board[i * 3] != '' &&
          board[i * 3] == board[i * 3 + 1] &&
          board[i * 3] == board[i * 3 + 2]) {
        return true;
      }
    }
    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      return true;
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      return true;
    }
    return false;
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Expanded(
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    for (int j = 0; j < 3; j++)
                      GestureDetector(
                        onTap: () => onTileTapped(i * 3 + j),
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              board[i * 3 + j],
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                 ],
                ),
              ),
          ],
        ),
      ),
    );
 }
}