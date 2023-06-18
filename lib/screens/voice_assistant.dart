import 'dart:convert';

import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../components/back_button.dart';

class VoiceAssistant extends StatefulWidget {
  const VoiceAssistant({Key? key, required this.selectScreen})
      : super(key: key);

  final Function(int) selectScreen;
  @override
  _VoiceAssistantState createState() => _VoiceAssistantState();
}

class _VoiceAssistantState extends State<VoiceAssistant> {
  final speechToText = SpeechToText();
  String lastWords = '';

  _VoiceAssistantState() {
    AlanVoice.addButton(
        "3483fcb8ac1b2eb5978e1106e78d7c512e956eca572e1d8b807a3e2338fdd0dc/stage");

    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> sendData() async {
    var isActive = await AlanVoice.isActive();
    if (!isActive) {
      AlanVoice.activate();
    }
    var params = jsonEncode({"count": 32});
    AlanVoice.callProjectApi("script::getCount", params);
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();

    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
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

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
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
              widget.selectScreen(1);
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
                  lastWords.isEmpty ? 'Tap to speak...' : lastWords,
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xFF5C5C5C)),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ))
        ]),
      ),
    );
  }
}
