import 'dart:async';

import 'package:rxdart/rxdart.dart';

class TimerService {
  BehaviorSubject<int> timer = BehaviorSubject.seeded(0);
  Stream<int> get timerStream => timer.stream;
  Sink<int> get timerSink => timer.sink;

  Duration duration = const Duration(seconds: 1);
  Timer? _timer;

  void start({Duration? duration}) async {
    if (duration != null) this.duration = duration;
    _timer = Timer.periodic(this.duration, (_) {
      timerSink.add(timer.value++);
    });
  }

  void pause() async {
    _timer?.cancel();
  }

  void resume() {
    _timer = Timer.periodic(duration, (_) {
      timerSink.add(timer.value++);
    });
  }

  void cancel() {
    timer.close();
    _timer?.cancel();
  }
}
