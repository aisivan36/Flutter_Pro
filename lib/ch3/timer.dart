import 'timermodel.dart';

/// The [_radius] is what we will use to express the percentage of completed time.
/// The [_isActive] Boolean will tell us if the counter is active or not, when the user presses the stop button, it will become inactive.
/// A [Timer] is class that you can use to create countdown timers.
/// We have created a Timer called  timer. There are two Duration fields of:
/// [_time] which we will use to express the remaining time, and [_fulltime] which is the beginning time `a short break, for instance maybe 5 minutes`.
class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer timer;
  Duration? _time;
  Duration? _fullTime;

  ///A brief explanation of this.
  ///Duration is a Dart class used to contain a span of time.
  /// What happens in the preceding code is that the Duration that's passed to the function gets transformed into a String,
  ///  with two digits for the minutes and two digits for the seconds,
  /// for example, ["05:42"]. With the inMinutes property, we get the minutes,
  /// and with the inSeconds, the total seconds in a Duration object.
  ///  We make sure that, if minutes or seconds have only one digit, we add a ["0"] before the number,
  ///  and then concatenate the two values with a [":"] sign. At the end of the function, we return the formatted string.
  String returnTIme(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();

    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }
}
