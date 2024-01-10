import 'dart:math';

import 'package:flutter/material.dart';

class GuessingScreen extends StatefulWidget {
  const GuessingScreen({Key? key}) : super(key: key);

  @override
  State<GuessingScreen> createState() => _GuessingScreenState();
}

class _GuessingScreenState extends State<GuessingScreen> {
  late int targetNumber;
  TextEditingController guessController = TextEditingController();
  List<String> feedbackList = [];
  bool showFeedback = false;
  int guessCount = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    setState(() {
      targetNumber = Random().nextInt(100) + 1;
      guessController.text = "";
      showFeedback = false;
      feedbackList.clear();
      guessCount = 0;
      gameOver = false;
    });
  }

  void checkGuess() {
    if (gameOver) return;

    int? userGuess = int.tryParse(guessController.text);

    if (userGuess == null) {
      setState(() {
        feedbackList.add("Please enter a valid number.");
        showFeedback = true;
      });
    } else {
      setState(() {
        guessCount++;
        if (userGuess == targetNumber) {
          feedbackList.add("Congratulations! You guessed the correct number!");
        } else if (userGuess < targetNumber) {
          feedbackList.add("The number is greater than $userGuess. Try again!");
        } else {
          feedbackList.add("The number is smaller than $userGuess. Try again!");
        }
        if (guessCount == 5) {
          feedbackList.add(
              "Sorry, you've reached the maximum number of guesses. The number is $targetNumber.");
          gameOver = true;
        }
        showFeedback = true;
      });
    }
  }

  void provideHint() {
    setState(() {
      if (targetNumber % 2 == 0) {
        feedbackList.add("Hint: The number is even.");
      } else {
        feedbackList.add("Hint: The number is odd.");
      }
      showFeedback = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Guessing Game",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF69B7F0),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Guess the number between 1 to 100...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  startNewGame();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF69B7F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  "New Game",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Your guess:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: guessController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: "Enter number here..",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF69B7F0),
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      checkGuess();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF69B7F0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      "Guess",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provideHint();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF69B7F0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      "Hint! Please",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (showFeedback)
                ListView.builder(
                  itemCount: feedbackList.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) => Container(
                    height: 80,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        children: [
                          if (feedbackList[index].contains("Congratulations"))
                            TextSpan(
                              text: feedbackList[index],
                              style: const TextStyle(color: Colors.green),
                            )
                          else if (feedbackList[index].contains("smaller"))
                            TextSpan(
                              text: feedbackList[index],
                              style: const TextStyle(color: Colors.red),
                            )
                          else if (feedbackList[index].contains("greater"))
                            TextSpan(
                              text: feedbackList[index],
                              style: const TextStyle(color: Colors.blue),
                            )
                          else if (feedbackList[index].contains("Hint"))
                            TextSpan(
                              text: feedbackList[index],
                              style: const TextStyle(color: Colors.orange),
                            )
                          else
                            TextSpan(
                              text: feedbackList[index],
                              style: const TextStyle(color: Colors.black),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
