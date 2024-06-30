import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class PointScreen extends StatelessWidget {
  const PointScreen({super.key});

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
        body: SafeArea(
          child: Column(
            children: [
              const Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/point.png'),
                  ),
                ),
              ),
              const Spacer(),
              Positioned(
                child: Container(
                  height: 600,
                  width: 350,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 15, 20, 15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 40,
                                blurStyle: BlurStyle.outer,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          // height: 50,
                          // width: 350,
                          child: Row(
                            children: [
                              const Text(
                                'user',
                                style: TextStyle(fontSize: 25),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.check_box_outline_blank,
                                color: kColorGray,
                                size: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.close,
                                color: kColorRed,
                                size: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.check,
                                color: kColorGreen,
                                size: 50,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // playerRow(),
                        Column(
                          children: [
                            FutureBuilder(
                              future: loadData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  List<String> resultList = snapshot.data;

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: resultList.length,
                                    itemBuilder: (context, index) {
                                      return playerRow(
                                          resultList[index].split('/')[0],
                                          resultList[index].split('/')[1],
                                          resultList[index].split('/')[2],
                                          resultList[index].split('/')[3]);
                                    },
                                  );
                                } //
                                else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget playerRow(String name, String correct, String wrong, String white) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          gradient: LinearGradient(colors: [
            int.parse(correct) > 6 ? lColorGreen : lColorRed,
            Colors.white
          ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 25),
          ),
          const Spacer(),
          Text(
            (white),
            style: TextStyle(fontSize: 40, color: kColorGray),
          ),
          const SizedBox(
            width: 35,
          ),
          Text(
            (wrong),
            style: TextStyle(fontSize: 40, color: kColorRed),
          ),
          const SizedBox(
            width: 35,
          ),
          Text(
            (correct),
            style: TextStyle(fontSize: 40, color: kColorGreen),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Future<List<String>> loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('scores') ?? [];
  }
}
