class Question {
  String question;
  String answer1;
  String answer2;
  int trueAnswer;
  String imageAddress;

  Question(this.question, this.answer1, this.answer2, this.trueAnswer,
      this.imageAddress);

  bool isRight(int answer) {
    if (answer == trueAnswer) {
      return true;
    } else {
      return false;
    }
  }
}

List<Question> questionList = [
  Question('Is sea color blue?', 'Yes', 'No', 1, 'assets/images/sea.png'),
  Question('Is apple yellow?', 'Yes', 'No', 2, 'assets/images/apple.png'),
  Question('What is this?', 'lion', 'cat', 2, 'assets/images/cat.png'),
  Question('What is this?', 'banana', 'orange', 1, 'assets/images/banana.png'),
  Question('Is this cat?', 'Yes', 'No', 2, 'assets/images/cow.png'),
  Question('What is this?', 'gun', 'knife', 1, 'assets/images/gun.png'),
  Question('Is fire cold?', 'Yes', 'No', 2, 'assets/images/fire.png'),
  Question('Is milk black?', 'Yes', 'No', 2, 'assets/images/milk.png'),
  Question('Is night dark?', 'Yes', 'No', 1, 'assets/images/night.png'),
  Question('What is this?', 'tree', 'flower', 1, 'assets/images/tree.png'),
];
