import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guessinggame/guessing_screen_controller.dart';


class GuessingScreen extends StatelessWidget {
  final GuessingController controller = Get.put(GuessingController());

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
                  controller.startNewGame();
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
                controller: controller.guessController,
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
                      controller.checkGuess();
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
                      controller.provideHint();
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
              Obx(
                () => Visibility(
                  visible: controller.showFeedback.value,
                  child: ListView.builder(
                    itemCount: controller.feedbackList.length,
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
                            if (controller.feedbackList[index]
                                .contains("Congratulations"))
                              TextSpan(
                                text: controller.feedbackList[index],
                                style: const TextStyle(color: Colors.green),
                              )
                            else if (controller.feedbackList[index]
                                .contains("smaller"))
                              TextSpan(
                                text: controller.feedbackList[index],
                                style: const TextStyle(color: Colors.red),
                              )
                            else if (controller.feedbackList[index]
                                .contains("greater"))
                              TextSpan(
                                text: controller.feedbackList[index],
                                style: const TextStyle(color: Colors.blue),
                              )
                            else if (controller.feedbackList[index]
                                .contains("Hint"))
                              TextSpan(
                                text: controller.feedbackList[index],
                                style: const TextStyle(color: Colors.orange),
                              )
                            else
                              TextSpan(
                                text: controller.feedbackList[index],
                                style: const TextStyle(color: Colors.black),
                              ),
                          ],
                        ),
                      ),
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
