import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/quiz_controller.dart';
import 'package:quiz/View/quiz_screen/quiz_screen.dart';
import 'package:quiz/constants.dart';

import '../Widgets/custom_buttons.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    Get.offAndToNamed(QuizScreen.routeName);
    Get.find<QuizController>().startTimer();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/spong.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 35,),
                      Center(
                        child: Text(
                          'Let\'s start Quiz !',
                          style: TextStyle(
                            color: KPrimaryColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Center(
                        child: Text(
                          'Enter your name to start : ',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                                color: KPrimaryColor,
                                fontSize: 25,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formkey,
                        child: GetBuilder<QuizController>(
                          init: Get.find<QuizController>(),
                          builder: (controller) => TextFormField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return 'Name should not be empty';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (String? val) {
                              controller.name = val!.trim().toUpperCase();
                            },
                            onFieldSubmitted: (_) => _submit(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      CustomButton(
                        width: double.infinity,
                        onPressed: () => _submit(context),
                        text: 'Start Quiz !',
                      ),
                      SizedBox(
                        height: 170,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
