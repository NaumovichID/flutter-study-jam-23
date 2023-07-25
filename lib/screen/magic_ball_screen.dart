import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/view/magic_ball_view.dart';

import 'api_constants.dart';
import 'model/magic_ball.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  MagicBallScreenState createState() => MagicBallScreenState();
}

class MagicBallScreenState extends State<MagicBallScreen> {
  final MagicBall magicBall = MagicBall(MagicBallState.waiting);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 211, 211, 255)],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 44.0,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _askMagicBall,
                  child: MagicBallView(key: UniqueKey(),
                      state: magicBall.state, reading: magicBall.reading),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 80.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Press the magic ball or shake your phone',
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 108, 105, 140),
                      ),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _askMagicBall() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.readingEndpoint));
      if (response.statusCode == 200) {
        setState(() {
          magicBall.state = MagicBallState.reading;
          magicBall.reading = json.decode(response.body)['reading'];
        });
      } else {
        setState(() {
          magicBall.state = MagicBallState.error;
          magicBall.reading = null;
        });
      }
    } catch (e, stacktrace) {
      log('$stacktrace');
      setState(() {
        magicBall.state = MagicBallState.error;
        magicBall.reading = null;
      });
    }
  }
}
