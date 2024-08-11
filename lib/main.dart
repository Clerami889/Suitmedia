import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suit_media/user_controller.dart';
import 'package:suit_media/second_screen.dart';

void main() {
  Get.put(UserController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  final TextEditingController palindromeController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isPalindrome(String text) {
    String cleanedText = text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    String reversedText = cleanedText.split('').reversed.join('');
    return cleanedText == reversedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromARGB(255, 174, 203, 236),
              Color.fromARGB(255, 26, 153, 212),
              Color.fromARGB(255, 147, 255, 246),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            transform: GradientRotation(7),
          ),
        ),
        child: Tampilan(),
      ),
    );
  }

  Padding Tampilan() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 100,
            onPressed: () {},
            icon: const Icon(Icons.account_circle_rounded),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: palindromeController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                labelText: 'Enter text to check Palindrome'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Enter username',
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Palindrome(),
          Next(),
        ],
      ),
    );
  }

  ElevatedButton Next() {
    return ElevatedButton(
      onPressed: () {
        Get.to(SecondScreen(username: usernameController.text));
      },
      child: const Text('Next'),
    );
  }

  ElevatedButton Palindrome() {
    return ElevatedButton(
      onPressed: () {
        String text = palindromeController.text;
        if (text.isNotEmpty) {
          bool result = isPalindrome(text);
          Get.defaultDialog(
            title: 'Result',
            middleText: result
                ? 'The Text is Palindrome'
                : 'The Text is not Palindrome',
          );
        } else {
          Get.defaultDialog(title: 'Error', middleText: 'Please enter text');
        }
      },
      child: const Text('Check'),
    );
  }
}
