import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  final FlutterTts tts = FlutterTts();

  TextToSpeechService() {
    init();
  }

  Future<void> init() async {
    await tts.setLanguage('en-US');
    // await tts.setVoice({"name": "Karen", "locale": "en-AU"});
    await tts.setSpeechRate(0.1);
    await tts.setVolume(1.0);
    await tts.setPitch(1.0);
    await tts.setQueueMode(1);
  }

  Future<void> speak(String text) async {
    tts.speak(text);
  }

  Future<void> stop() async {
    tts.stop();
  }
}
