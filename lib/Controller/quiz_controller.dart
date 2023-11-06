import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/View/result_screen/result_screen.dart';
import 'package:quiz/View/welcome_screen.dart';

import '../Model/questions.dart';

class QuizController extends GetxController {
  String name = '';
  final List<QuestionModel> _questionList = [
    QuestionModel(
      id: 1,
      question: "What is the best meal for Hazar ?",
      answer: 2,
      options: ['Pizza', 'Indomi', 'Mlokhya', 'Kabsa'],
    ),
    QuestionModel(
      id: 2,
      question: "What are the best colors for Hazar ?",
      answer: 4,
      options: ['White', 'Green', 'Black', 'Green And White'],
    ),
    QuestionModel(
      id: 3,
      question: "Who is Hazar\'s Brother ?",
      answer: 3,
      options: ['Nazih', 'Nour', 'Nezar', 'Rami'],
    ),
    QuestionModel(
      id: 4,
      question: "What Does Hazar Study?",
      answer: 1,
      options: ['ITE', 'Architecture', 'Art', 'History'],
    ),
    QuestionModel(
      id: 5,
      question: "Is Hazar Single?",
      answer: 4,
      options: ['Yes', 'No', 'May be', 'IDN'],
    ),
    QuestionModel(
      id: 6,
      question: "How Old is Hazar?",
      answer: 2,
      options: ['20', '22', '23', '24'],
    ),
    QuestionModel(
      id: 7,
      question: "What is Hazar\'s Best Friend Name?",
      answer: 1,
      options: ['Douaa', 'Laila', 'Ghofran', 'Doha'],
    ),
    QuestionModel(
      id: 8,
      question: "What is the best activity for Hazar?",
      answer: 1,
      options: ['Drawing', 'Dancing', 'Singing', 'Playing Tennis'],
    ),
    QuestionModel(
      id: 9,
      question: "What is color of Hazar\'s eyes?",
      answer: 4,
      options: ['Grey', 'Green', 'Black', 'Brown'],
    ),
    QuestionModel(
      id: 10,
      question: "What is the country that Hazar want to go?",
      answer: 3,
      options: ['Germany', 'Lebanon', 'UAE', 'Iraq'],
    ),
  ];

  bool _isPressed = false;
  double _numberOfQuestions = 1;
  int? _selectedAnswer;
  int _countOfCorrectAnswer = 0;
  final RxInt _sec = 15.obs;

  int get countOfQuestions => _questionList.length;
  List<QuestionModel> get questionList => [..._questionList];
  bool get isPressed => _isPressed;
  double get numberOfQuestions => _numberOfQuestions;
  int? get selectedAnswer => _selectedAnswer;
  int get countOfCorrectAnswer => _countOfCorrectAnswer;
  RxInt get sec => _sec;

  int? _correctAnswer;
  final Map<int, bool> _questionIsAnswered  = {};
  Timer? _timer;
  final maxSec = 15;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswers();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  double get scoreResult {
    return countOfCorrectAnswer * 100 / _questionList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectedAnswer) {
    _isPressed = true;
    _selectedAnswer = selectedAnswer;
    _correctAnswer = questionModel.answer;
    if (_correctAnswer == _selectedAnswer) {
      _countOfCorrectAnswer++;
    }
    stopTimer();
    _questionIsAnswered.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());

    update();
  }

  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswered.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }
    if (pageController.page == _questionList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      startTimer();
    }
    _numberOfQuestions = pageController.page! + 2;
    update();
  }

  void resetAnswers() {
    for (var element in _questionList) {
      _questionIsAnswered.addAll({element.id: false});
    }
    update();
  }

  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green;
      } else if (answerIndex == _selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Colors.red;
      }
    }
    return Colors.white;
  }

  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswer = 0;
    _selectedAnswer = null;
    resetAnswers();
    Get.offAllNamed(WelcomeScreen.routeName);
  }

  void stopTimer() => _timer!.cancel();

  void resetTimer() => _sec.value = maxSec;
}
