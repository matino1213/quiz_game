import 'package:flutter/material.dart';
import 'package:quiz_game/screens/result_screen.dart';
import 'package:quiz_game/widgets/answer_container.dart';
import 'package:quiz_game/widgets/question_list_row.dart';

import '../constants.dart';
import '../models/question_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  ScrollController scrollController = ScrollController();
  int currentQuestionNumber = 0;
  int answerPressed = 1;
  bool isOnePressed = true;
  List statusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i <= questionList.length - 1; i++) {
      statusList.add(0);
    }
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if ((animation.value * 100).round() >= 98) {
            onNextPress(true);
          }
        });
      });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [lColorBlue, dColorBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: kColorBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: animation.value,
                      backgroundColor: kColorBlue,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: QuestionListRow(
                    scrollController: scrollController,
                    currentQuestionNumber: currentQuestionNumber,
                    statusList: statusList),
              ),
              SizedBox(
                height: 500,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 170,
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(35))),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      child: Container(
                        width: 220,
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40))),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        width: 320,
                        height: 350,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 30,
                              )
                            ],
                            gradient: LinearGradient(
                                colors: [vlColorBlue, Colors.white],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Center(
                                child: Text(
                              questionList[currentQuestionNumber].question,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: tColorBlue,
                              ),
                            )),
                            const Spacer(),
                            Row(
                              children: [
                                AnswerContainer(
                                    answer: questionList[currentQuestionNumber]
                                        .answer1,
                                    num: 1,
                                    isOnePressed: isOnePressed,
                                    answerPressed: answerPressed,
                                    onTap: () {
                                      isAnswerOnPressed(1);
                                    }),
                                const Spacer(),
                                AnswerContainer(
                                    answer: questionList[currentQuestionNumber]
                                        .answer2,
                                    num: 2,
                                    isOnePressed: isOnePressed,
                                    answerPressed: answerPressed,
                                    onTap: () {
                                      isAnswerOnPressed(2);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        child: SizedBox(
                            height: 200,
                            width: 250,
                            child: Image(
                              image: AssetImage(
                                  questionList[currentQuestionNumber]
                                      .imageAddress),
                            )))
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Material(
                    color: klColorBlue,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                      onTap: () {
                        onNextPress(false);
                      },
                      child: const SizedBox(
                        width: 260,
                        height: 100,
                        child: Center(
                          child: Text(
                            'Next',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Material(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                    color: dColorPurple,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                      onTap: () {
                        myNavigator();
                      },
                      child: const SizedBox(
                        height: 100,
                        width: 90,
                        child: Icon(Icons.golf_course,
                            color: Colors.white, size: 50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onNextPress(bool isFromTimer) {
    scrollController.animateTo(currentQuestionNumber * 65,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    if (isFromTimer) {
      statusList[currentQuestionNumber] = 0;
    } else {
      checkedAnswer();
    }
    if (currentQuestionNumber <= questionList.length - 2) {
      currentQuestionNumber++;
      setState(() {});
    } else {
      myNavigator();
    }
    if (controller.isAnimating) {
      controller.reset();
      controller.forward();
    }
  }

    void checkedAnswer() {
    bool status = questionList[currentQuestionNumber].isRight(answerPressed);
    statusList[currentQuestionNumber] = status;
  }

  List<int> grader() {
    int trueAnswer = 0;
    int falseAnswer = 0;
    int whiteAnswer = 0;
    for (var item in statusList) {
      if (item == true) {
        trueAnswer++;
      } else if (item == false) {
        falseAnswer++;
      } else {
        whiteAnswer++;
      }
    }

    return [trueAnswer, falseAnswer, whiteAnswer];
  }

  myNavigator() {
    controller.reset();
    controller.dispose();
    List<int> resultList = grader();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            resultList: resultList,
          ),
        ));
  }

  isAnswerOnPressed(int num) {
    if (num == 1) {
      setState(() {
        isOnePressed = true;
        answerPressed = 1;
      });
    } //
    else {
      setState(() {
        isOnePressed = false;
        answerPressed = 2;
      });
    }
  }
}
