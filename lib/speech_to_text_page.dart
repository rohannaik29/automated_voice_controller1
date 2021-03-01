import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'SendToRaspberryPi.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {

  final Map<String, HighlightedWord> _highlights = {
    'left': HighlightedWord(
      onTap: () => print('left'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'right': HighlightedWord(
      onTap: () => print('right'),

      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'stop': HighlightedWord(
      onTap: () => print('stop'),

      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'backward': HighlightedWord(
      onTap: () => print('backward'),
      textStyle: const TextStyle(
        color: Colors.greenAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'forward': HighlightedWord(
      onTap: () => print('forward'),
      textStyle: const TextStyle(
        color: Colors.teal,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',),
        backgroundColor: Colors.deepPurple[300],
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text == ''? 'Press the button and start speaking': _text,
            words: _highlights,
            textStyle: TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;



            if(_text.contains('left'))
              SendToRaspberryPi().sendToRaspberryPi('Left');

            if(_text.contains('right'))
              SendToRaspberryPi().sendToRaspberryPi('Right');

            if(_text.contains('forward'))
              SendToRaspberryPi().sendToRaspberryPi('Forward');

            if(_text.contains('backward'))
              SendToRaspberryPi().sendToRaspberryPi('Backward');

            if(_text.contains('stop'))
              SendToRaspberryPi().sendToRaspberryPi('Stop');

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
              setState(() => _isListening = false);
            }
          }),
        );
      }
    }
    else
      {
        _speech.stop();
      }

  }
}