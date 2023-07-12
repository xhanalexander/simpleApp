import 'package:flutter/material.dart';
import 'package:simpleapp/components/custom_component.dart';
import 'package:simpleapp/views/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final nameController = TextEditingController();
  late final palindromController = TextEditingController();

  void checkPalindrome() {
  String word = palindromController.text.trim();
  
    if (word.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan kata.'),
        ),
      );
      return;
    }
    bool isPalindrome = isWordPalindrome(word);
    if (isPalindrome) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 700),
          content: Text('is Palindrome.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 700),
          content: Text('not palindrome.'),
        ),
      );
    }
  }

  bool isWordPalindrome(String word) {
    String reversedWord = String.fromCharCodes(word.runes.toList().reversed);
    return word.toLowerCase() == reversedWord.toLowerCase();
  }

  @override
  void dispose() {
    palindromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/bgs.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: FloatingActionButton(
                      splashColor: Colors.white30,
                      backgroundColor: Colors.white54,
                      onPressed: () {},
                      child: const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  CustomInputForm(hintTextName: "Name", controllerNames: nameController),
                  const SizedBox(height: 10),
                  CustomInputForm(hintTextName: "Palindrome", controllerNames: palindromController),
                  const SizedBox(height: 30),
                  CustomElevatedButton(text: "CHECK", onPressed: checkPalindrome),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    text: "NEXT", 
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SecondScreen(message: nameController.text),
                          transitionDuration: const Duration(seconds: 1),
                          transitionsBuilder: (_, __, ___, c) {
                            __ = CurvedAnimation(
                              parent: __,
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                            return FadeTransition(
                              opacity: __,
                              child: c,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}