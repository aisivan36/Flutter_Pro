import 'dart:async';

// import 'timermodel.dart';
import 'package:img_pict/ch3/timermodel.dart';

/// The [_radius] is what we will use to express the percentage of completed time.
/// The [_isActive] Boolean will tell us if the counter is active or not, when the user presses the stop button, it will become inactive.
/// A [Timer] is class that you can use to create countdown timers.
/// We have created a Timer called  timer. There are two Duration fields of:
/// [_time] which we will use to express the remaining time, and [_fulltime] which is the beginning time `a short break, for instance maybe 5 minutes`.
class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer? timer;
  Duration? _time;
  Duration? _fullTime;

  /// The work time that we need to change later on.
  int work = 30;

  void startWork() {
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }

  ///Stop button
  void stopTimer() {
    this._isActive = false;
  }

  ///Start button
  void startTimer() {
    if (_time!.inSeconds > 0) {
      this._isActive = true;
    }
  }

  ///A brief explanation of this.
  ///Duration is a Dart class used to contain a span of time.
  /// What happens in the preceding code is that the Duration that's passed to the function gets transformed into a String,
  ///  with two digits for the minutes and two digits for the seconds,
  /// for example, ["05:42"]. With the inMinutes property,
  /// we get the [minutes],
  /// and with the [inSeconds], the total seconds in a Duration object.
  ///  We make sure that, if minutes or seconds have only one digit, we add a ["0"] before the number,
  ///  and then concatenate the two values with a [":"] sign. At the end of the function, we return the formatted string.
  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();

    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  ///A brief explanation of this.
  ///The stream() method returns a Stream. A stream is generic, meaning that you can return a Stream of any type.
  ///In this case, we are returning a Stream of [TimerModel]. The method is `asynchronous` which is a `(async*)` syntax.
  ///`In flutter, you can use `async` without the `*` sign for [Futures] and the `async*` with the `*` sign for Streams.`
  /// ==== More brief about `Stream and Future` === is:.
  ///What's the difference between a `Stream` and a `Future`? It's that any number of events can be returned in a `Stream`,
  /// whereas a `Future` only returns once.
  /// When you mark a function with the `async*` that you are creating a generator function.
  Stream<TimerModel> stream() async* {
    //
    /// A brief explanation of `yield*`.
    /// You use the yield* statement to deliver a result. To make it simple,
    /// it's like a return statement, but it doesn't end the function.
    ///  As stated previously, you use the "*" sign after yield because we are returning a Stream; if it were a single value,
    /// you would just use yield. The code can be seen in the following snippet:
    /// `Stream.periodic()` is a constructor creating a `Stream` that emits events at the intervals specified in the first parameter.
    /// In our code, this will emit a value every 1 second.
    ///
    ///
    yield* Stream.periodic(
      Duration(seconds: 1),
      (int a) {
        String time;
        if (this._isActive) {
          _time = _time! - Duration(seconds: 1);
          _radius = _time!.inSeconds / _fullTime!.inSeconds;
          if (_time!.inSeconds <= 0) {
            _isActive = false;
          }
        }
        time = returnTime(_time!);
        return TimerModel(time, _radius);
      },
    );
  }
  ///// ============== The end of the Stream ===========
}
