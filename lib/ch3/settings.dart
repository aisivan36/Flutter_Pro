import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = TextStyle(fontSize: 24.0);

  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int? workTime;
  int? shortBreak;
  int? longBreak;

  late SharedPreferences prefs;

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if (workTime != null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if (workTime == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if (workTime == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork?.text = workTime as String;
      txtShort?.text = shortBreak.toString();
      txtLong?.text = longBreak.toString();
    });
  }

  @override
  void initState() {
    TextEditingController? txtWork = TextEditingController();
    TextEditingController? txtShort = TextEditingController();
    TextEditingController? txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME) as int;
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork!.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK) as int;
          short += value;
          if (short >= 1 && short <= 120) {
            setState(() {
              txtShort!.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK) as int;
          long += value;
          if (long >= 1 && long <= 180) {
            setState(() {
              txtLong!.text = long.toString();
            });
          }
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          Text(
            "Work",
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455a64),
            text: '-',
            value: -1,
            callback: updateSetting,
            setting: WORKTIME,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: "+",
            value: 1,
            callback: updateSetting,
            setting: WORKTIME,
          ),
          Text(
            'Short',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455a64),
            text: ('-'),
            value: -1,
            callback: updateSetting,
            setting: SHORTBREAK,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: '+',
            value: -1,
            callback: updateSetting,
            setting: SHORTBREAK,
          ),
          Text(
            'Long',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455a64),
            text: '-',
            value: -1,
            callback: updateSetting,
            setting: LONGBREAK,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: '+',
            value: -1,
            callback: updateSetting,
            setting: LONGBREAK,
          ),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String setting;
  final double? size;
  final CallbackSetting callback;

  const SettingButton({
    Key? key,
    required this.color,
    required this.text,
    required this.value,
    this.size,
    required this.callback,
    required this.setting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => this.callback(this.setting, this.value),
      color: this.color,
      minWidth: this.size,
    );
  }
}
