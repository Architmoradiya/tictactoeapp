import 'package:flutter/material.dart';

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  // Game board and current player
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';

  // Game state
  bool gameEnded = false;
  String winner = '';

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      gameEnded = false;
      winner = '';
    });
  }

  void makeMove(int index) {
    if (board[index] == '' && !gameEnded) {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner()) {
          gameEnded = true;
          winner = currentPlayer;
        } else if (!board.contains('')) {
          gameEnded = true;
          winner = 'Draw';
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWinner() {
    // Winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2], // Row 1
      [3, 4, 5], // Row 2
      [6, 7, 8], // Row 3
      [0, 3, 6], // Column 1
      [1, 4, 7], // Column 2
      [2, 5, 8], // Column 3
      [0, 4, 8], // Diagonal 1
      [2, 4, 6], // Diagonal 2
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] == currentPlayer &&
          board[combo[1]] == currentPlayer &&
          board[combo[2]] == currentPlayer) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Game board
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => makeMove(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: TextStyle(
                        color: board[index] == 'X' ? Colors.red : Colors.blue,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Game status
          Text(
            gameEnded
                ? (winner == 'Draw' ? 'It\'s a Draw!' : 'Winner: $winner')
                : 'Current Player: $currentPlayer',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Restart button
          ElevatedButton(
            onPressed: resetGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text(
              'Restart Game',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
