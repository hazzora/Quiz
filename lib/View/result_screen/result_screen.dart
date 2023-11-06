import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/quiz_controller.dart';
import 'package:quiz/constants.dart';

import '../../Widgets/custom_buttons.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: GetBuilder<QuizController>(
              init: Get.find<QuizController>(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height:100,),
                  Text(
                    'Congratulations !',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                      fontSize: 35,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.name,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: KPrimaryColor,
                      fontSize: 30,
                        ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Your score is: ',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                      fontSize: 35,
                        ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    '${controller.scoreResult.round()} /100',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: KPrimaryColor,
                      fontSize: 30,
                        ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  CustomButton(
                    onPressed: () => controller.startAgain(),
                    text: 'Start Again',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
