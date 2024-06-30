import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:quiz_game/constants.dart';
import 'package:quiz_game/screens/point_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.resultList});

  final List<int> resultList;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isWinner = true;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isWinner = checkWinner();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [lColorBlue, dColorBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 680,
                      width: 370,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                isWinner ? lColorGreen : lColorRed,
                                Colors.white,
                                Colors.white
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(100))),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              alignment: Alignment.center,
                              width: 300,
                              height: 550,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(50),
                                      bottom: Radius.circular(100))),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 190,
                                  ),
                                  Text(
                                    isWinner
                                        ? 'you are winner!'
                                        : 'you are loser',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            isWinner ? dColorGreen : kColorRed,
                                        fontSize: 50),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 220,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      color: isWinner ? dColorGreen : kColorRed,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  pointRow(
                                      Icons.check,
                                      'correct',
                                      widget.resultList[0].toString(),
                                      dColorGreen),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  pointRow(
                                      Icons.close,
                                      'wrong',
                                      widget.resultList[1].toString(),
                                      kColorRed),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  pointRow(
                                      Icons.check_box_outline_blank,
                                      'white',
                                      widget.resultList[2].toString(),
                                      kColorGray),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                              top: 20,
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: Image(
                                    image:
                                        AssetImage("assets/images/result.png")),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myButton(
                          color: kColorYellow,
                          text: 'play again',
                          onTap: () {
                            onPlayAgainPressed();
                          },
                          width: 180),
                      const SizedBox(
                        width: 20,
                      ),
                      myButton(
                          color: Colors.white,
                          text: 'result',
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.infoReverse,
                              headerAnimationLoop: false,
                              btnOkOnPress: () {
                                onOkPressed();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => const PointScreen(),
                                //     ));
                                // Navigator.push(
                                //     context,
                                //     DialogRoute(
                                //       context: context,
                                //       builder: (context) => PointScreen(
                                //           name: controller.text,
                                //           statusList: widget.resultList),
                                //     ));
                              },
                              btnCancelOnPress: () {},
                              body: Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      'enter your name',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    SizedBox(
                                      width: 170,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: controller,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              title: 'This is Ignored',
                              desc: 'This is also Ignored',
                            ).show();
                          },
                          width: 180),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkWinner() {
    if (widget.resultList[0] >= 7) {
      return true;
    } else {
      return false;
    }
  }

  Widget pointRow(IconData icon, String text, String number, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Icon(
          icon,
          color: color,
          size: 50,
        ),
        Text(
          text,
          style: TextStyle(color: color, fontSize: 35),
        ),
        Text(
          number,
          style: TextStyle(color: color, fontSize: 45),
        ),
        const SizedBox(),
      ],
    );
  }

  Widget myButton(
      {required Color color,
      required String text,
      required VoidCallback onTap,
      required double width}) {
    return Material(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: SizedBox(
          width: width,
          height: 85,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  void onPlayAgainPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'would you like play again?',
              style: TextStyle(color: Colors.black, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: myButton(
                        color: lColorGreen,
                        text: 'yes',
                        onTap: () {
                          onYesPressed();
                        },
                        width: 50)),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: myButton(
                        color: lColorRed,
                        text: 'no',
                        onTap: () {
                          onNoPressed();
                        },
                        width: 50)),
              ],
            )
          ],
        ),
      ),
    );
  }

  onYesPressed() {
    Phoenix.rebirth(context);
  }

  onNoPressed() {
    clearData();
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void onOkPressed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    List<String> list = pref.getStringList('scores') ?? [];
    list.add(
        '${controller.text}/${widget.resultList[0].toString()}/${widget.resultList[1].toString()}/${widget.resultList[2].toString()}');
    await pref.setStringList('scores', list);
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PointScreen(),
        ));
    controller.clear();
  }

  void clearData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

}
