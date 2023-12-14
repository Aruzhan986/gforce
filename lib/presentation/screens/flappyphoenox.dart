import 'dart:async';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gforce/generated/locale_keys.g.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';

class FlappyBird extends StatefulWidget {
  @override
  _FlappyBirdState createState() => _FlappyBirdState();
}

class _FlappyBirdState extends State<FlappyBird> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  double barrierXone = 0;
  late double barrierXtwo;

  int score = 0;
  int bestScore = 0;

  @override
  void initState() {
    super.initState();
    barrierXtwo = barrierXone + 1.5;
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    time = 0;
    initialHeight = birdYaxis;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYaxis = initialHeight - height;
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });

      if (barrierXone < -2) {
        barrierXone += 3.5;
        score++;
      }
      if (barrierXtwo < -2) {
        barrierXtwo += 3.5;
        score++;
      }

      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
        bestScore = max(score, bestScore);
        score = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                if (gameHasStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: PrimaryColors.Colorseven,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted
                        ? Text("")
                        : Text(
                            LocaleKeys.Tap.tr(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.3),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.3),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 250.0),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 15,
            color: PrimaryColors.Coloreleven,
          ),
          Expanded(
            child: Container(
              color: PrimaryColors.Coloretwoel,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.SCORE.tr(),
                          style: TextStyle(
                              color: PrimaryColors.Colorfour, fontSize: 20)),
                      SizedBox(height: 20),
                      Text(score.toString(),
                          style: TextStyle(
                              color: PrimaryColors.Colorfour, fontSize: 35)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.BEST.tr(),
                          style: TextStyle(
                              color: PrimaryColors.Colorfour, fontSize: 20)),
                      SizedBox(height: 20),
                      Text(bestScore.toString(),
                          style: TextStyle(
                              color: PrimaryColors.Colorfour, fontSize: 35)),
                    ],
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

class MyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Image.asset('assets/images/gforce.png'),
    );
  }
}

class MyBarrier extends StatelessWidget {
  final double size;

  MyBarrier({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: size,
      decoration: BoxDecoration(
        color: PrimaryColors.Coloreleven,
        border: Border.all(width: 10, color: PrimaryColors.Colorfive),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
