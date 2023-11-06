import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Utiles/binding.dart';
import 'package:quiz/View/quiz_screen/quiz_screen.dart';
import 'package:quiz/View/result_screen/result_screen.dart';
import 'package:quiz/View/welcome_screen.dart';

main() {
  runApp(Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      initialBinding: MyBinding(),
      getPages: [
        GetPage(
          name: WelcomeScreen.routeName,
          page: () => WelcomeScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => ResultScreen(),
        ),
        GetPage(
          name: QuizScreen.routeName,
          page: () => QuizScreen(),
        ),
      ],
    );
  }
}
