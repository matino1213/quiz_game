import 'package:flutter/material.dart';
import 'question_num.dart';
import '../models/question_model.dart';

class QuestionListRow extends StatelessWidget {
  const QuestionListRow(
      {super.key,
      required this.scrollController,
      required this.currentQuestionNumber,
      required this.statusList});

  final ScrollController scrollController;

  // ignore: prefer_typing_uninitialized_variables
  final currentQuestionNumber;
  final List statusList;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (int i = 1; i <= questionList.length; i++) {
      list.add(QuestionNum(
          num: i,
          currentQuestionNumber: currentQuestionNumber,
          statusList: statusList));
    }
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }
}
