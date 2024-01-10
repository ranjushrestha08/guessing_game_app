import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuessingController extends GetxController {
  late int targetNumber;
  TextEditingController guessController = TextEditingController();
  RxList<String> feedbackList = <String>[].obs;
  RxBool showFeedback = false.obs;
  int guessCount = 0;
  RxBool gameOver = false.obs;

  @override
  void onInit() {
    super.onInit();
    startNewGame();
  }

  void startNewGame() {
    targetNumber = Random().nextInt(100) + 1;
    guessController.text = "";
    showFeedback.value = false;
    feedbackList.clear();
    guessCount = 0;
    gameOver.value = false;
  }

  void checkGuess() {
    if (gameOver.value) return;

    int? userGuess = int.tryParse(guessController.text);

    if (userGuess == null) {
      feedbackList.add("Please enter a valid number.");
      showFeedback.value = true;
    } else {
      guessCount++;
      if (userGuess == targetNumber) {
        feedbackList.add("Congratulations! You guessed the correct number!");
        gameOver.value = true;
      } else if (userGuess < targetNumber) {
        feedbackList.add("The number is greater than $userGuess. Try again!");
      } else {
        feedbackList.add("The number is smaller than $userGuess. Try again!");
      }
      if (guessCount == 5 && !gameOver.value) {
        feedbackList.add(
            "Sorry, you've reached the maximum number of guesses. The number is $targetNumber.");
        gameOver.value = true;
      }
      guessController.clear();

      showFeedback.value = true;
    }
  }

  void provideHint() {
    if (!gameOver.value) {
      if (targetNumber % 2 == 0) {
        feedbackList.insert(0, "Hint: The number is even.");
      } else {
        feedbackList.insert(0, "Hint: The number is odd.");
      }
      showFeedback.value = true;
    }
  }
}
