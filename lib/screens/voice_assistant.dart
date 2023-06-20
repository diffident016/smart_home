import 'dart:async';

import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:wokwi_talkie/components/utils.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wokwi_talkie/models/fans.dart';
import 'package:wokwi_talkie/models/lights.dart';
import 'package:wokwi_talkie/models/sockets.dart';

import '../components/back_button.dart';

class VoiceAssistant extends StatefulWidget {
  const VoiceAssistant(
      {Key? key,
      required this.selectScreen,
      required this.updateLights,
      required this.updateFans,
      required this.updateSocket,
      required this.lights,
      required this.fans,
      required this.sockets})
      : super(key: key);

  final Function(int) selectScreen;
  final VoidCallback updateSocket;
  final VoidCallback updateLights;
  final VoidCallback updateFans;
  final Lights lights;
  final Fans fans;
  final Sockets sockets;

  @override
  _VoiceAssistantState createState() => _VoiceAssistantState();
}

class _VoiceAssistantState extends State<VoiceAssistant> {
  final speechToText = SpeechToText();
  // final flutterTts = FlutterTts();
  String lastWords = '';
  TextToSpeech tts = TextToSpeech();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initSpeechToText();

    _timer = Timer(const Duration(seconds: 0), () {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  // Future<void> initTextToSpeech() async {
  //   await flutterTts.setSharedInstance(true);
  //   setState(() {});
  // }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {
      lastWords = 'Listening...';
    });
  }

  Future<void> stopListening() async {
    await speechToText.stop();

    setState(() {});
  }

  Future<void> systemSpeak(String content) async {
    tts.speak(content);

    _timer = Timer(const Duration(seconds: 4), () {
      setState(() {
        lastWords = '';
      });
    });
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });

    if (speechToText.isNotListening) {
      int command = Utils.readCommand(lastWords);
      String feedback = Utils.feedback(command);

      _response(Utils.response(command));
      systemSpeak(feedback);
    }
  }

  void _listen() async {
    if (await speechToText.hasPermission && speechToText.isNotListening) {
      await startListening();
    } else if (speechToText.isListening) {
      await stopListening();
    } else {
      initSpeechToText();
    }
  }

  void _response(List<int> res) {
    print(res);
    setState(() {
      if (res.isNotEmpty) {
        if (res[0] == 0) {
          widget.lights.lights[res[1]] = res[2] == 1 ? true : false;
          widget.updateLights();
        } else if (res[0] == 1) {
          widget.fans.fans[res[1]] = res[2] == 1 ? true : false;
          widget.updateFans();
        } else if (res[0] == 2) {
          widget.sockets.sockets[res[2]] = res[1] == 1 ? true : false;
          widget.updateSocket();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          CBackButton(
            onTap: (() {
              widget.selectScreen(0);
            }),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () async {
                    _listen();
                  },
                  child: Center(
                      child: Image.asset('assets/images/microphone.png'))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Text(
                  speechToText.isListening
                      ? "Listening..."
                      : lastWords.isEmpty
                          ? 'Tap to speak...'
                          : lastWords,
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xFF5C5C5C)),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ))
        ]),
      ),
    );
  }
}
