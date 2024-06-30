import 'package:flutter/material.dart';

import '../constants.dart';

class AnswerContainer extends StatelessWidget {
  const AnswerContainer({super.key, required this.answer, required this.num, required this.isOnePressed, required this.answerPressed, required this.onTap});
  final String answer;
  final int num;
  final bool isOnePressed;
  final int answerPressed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.symmetric(
        //     horizontal: 20, vertical: 40),

        width: 110,
        height: 60,
        decoration: BoxDecoration(
            color: isOnePressed && num == 1 || !isOnePressed && num == 2
                ? dColorPurple
                : kColorBlue,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: isOnePressed && num == 1 || !isOnePressed && num == 2
                      ? lColorPurple
                      : klColorBlue,
                  offset: const Offset(-5, -5)),
            ]),
        child: Center(
            child: Text(
          answer,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        )),
      ),
    );
  }
}
