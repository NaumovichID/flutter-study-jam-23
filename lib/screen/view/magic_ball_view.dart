import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/model/magic_ball.dart';

class MagicBallView extends StatelessWidget {
  String? reading;
  final MagicBallState state;

  MagicBallView({super.key, required this.state, this.reading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            states[state]!,
            height: 644,
            width: 644,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          constraints: const BoxConstraints.tightFor(height: 644, width: 644),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                (reading != null) ? reading! : '',
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 108, 105, 140),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
            totalRepeatCount: 1,
          ),
        ),
      ],
    );
  }
}

Map<MagicBallState, String> states = {
  MagicBallState.waiting: 'assets/images/ball_stars.png',
  MagicBallState.reading: 'assets/images/ball_reading.png',
  MagicBallState.error: 'assets/images/ball_error.png'
};
