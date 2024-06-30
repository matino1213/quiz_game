import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/question_model.dart';

class QuestionNum extends StatelessWidget {
  const QuestionNum({super.key, required this.num, required this.currentQuestionNumber, required this.statusList});
  final int num;
  final int currentQuestionNumber;
  final List statusList;

  @override
  Widget build(BuildContext context) {
    int temp = num - 1;
    Color color = kColorBlue;
    int size = questionList.length - 1;
    if (temp == currentQuestionNumber) {
      if (temp == size && statusList[temp] != 0) {
        if (statusList[temp] == true) {
          color = kColorGreen;
        } else if (statusList[temp] == false) {
          color = kColorRed;
        }
      } else {
        color = Colors.white;
      }
    } else {
      if (statusList[temp] == true) {
        color = kColorGreen;
      } else if (statusList[temp] == false) {
        color = kColorRed;
      }
    }
    return Container(
      height: temp == currentQuestionNumber ? 85 : 70,
      width: temp == currentQuestionNumber ? 85 : 70,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: Text(
          '$num',
          style: TextStyle(
              fontSize: temp == currentQuestionNumber ? 50 : 35,
              fontWeight: FontWeight.bold,
              color: temp == currentQuestionNumber ? kColorBlue : Colors.white),
        ),
      ),
    );
  }
}
