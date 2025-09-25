import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const UltraTicTacToe());
}

class UltraTicTacToe extends StatelessWidget {
  const UltraTicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ultra Tic Tac Toe",
      theme: ThemeData.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Home Page with 2 options
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[300], // 🔴 Background pink
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("ULTRA TIC TAC TOE",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              icon: const Icon(Icons.people, size: 30),
              label: const Text("2 PLAYER MODE",
                  style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const GamePage(isWithComputer: false)));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              icon: const Icon(Icons.smart_toy, size: 30),
              label: const Text("PLAYING WITH COMPUTER",
                  style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const GamePage(isWithComputer: true)));
              },
            ),

            // 🔴 Neeche text add kiya
            const SizedBox(height: 30),
            const Text(
              "Varmelpa Creation",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow),
            ),
            const SizedBox(height: 5),
            const Text(
              "Varmelpa Creation by Ultra Smite Gamerz",
              style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Game Page
class GamePage extends StatefulWidget {
  final bool isWithComputer;
  const GamePage({super.key, required this.isWithComputer});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board = List.filled(9, "");
  bool isXTurn = true;
  String winner = "";

  void playMove(int index) {
    if (board[index] == "" && winner == "") {
      setState(() {
        board[index] = isXTurn ? "X" : "O";
        isXTurn = !isXTurn;
        winner = checkWinner();
      });

      if (widget.isWithComputer && !isXTurn && winner == "") {
        Future.delayed(const Duration(milliseconds: 500), () {
          computerMove();
        });
      }
    }
  }

  void computerMove() {
    final emptyIndexes = [
      for (int i = 0; i < 9; i++) if (board[i] == "") i
    ];
    if (emptyIndexes.isNotEmpty) {
      final move = emptyIndexes[Random().nextInt(emptyIndexes.length)];
      setState(() {
        board[move] = "O";
        isXTurn = true;
        winner = checkWinner();
      });
    }
  }

  String checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];
      if (a != "" && a == b && b == c) {
        return a;
      }
    }

    if (!board.contains("")) return "Draw";
    return "";
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, "");
      isXTurn = true;
      winner = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Ultra Tic Tac Toe"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (winner != "")
            Column(
              children: [
                Text(
                  winner == "Draw"
                      ? "Game Draw!"
                      : "🎉 Congratulations! $winner Wins 🎉",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: resetGame,
                  child: const Text("Play Again"),
                )
              ],
            ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => playMove(index),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white)),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: board[index] == "X"
                              ? Colors.cyanAccent
                              : Colors.pinkAccent,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
