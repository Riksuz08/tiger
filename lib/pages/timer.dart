import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/shared_prefs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Countdown Timer'),
        ),
        body: Center(
          child: CountdownTimer(),
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with WidgetsBindingObserver {
  late Timer _timer;
  int _hours = 23;
  int _minutes = 59;
  int _seconds = 59;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _loadSavedTime();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_hours == 0 && _minutes == 0 && _seconds == 0) {
          timer.cancel();
          SharedPrefs().saveBoolToSharedPreferences('open', true);
        } else {
          if (_seconds > 0) {
            _seconds--;
          } else {
            if (_minutes > 0) {
              _minutes--;
              _seconds = 59;
            } else {
              if (_hours > 0) {
                _hours--;
                _minutes = 59;
                _seconds = 59;
              }
            }
          }
          _saveTime(); // Save the remaining time
        }
      });
    });
  }

  Future<void> _loadSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _hours = prefs.getInt('hours') ?? 23;
      _minutes = prefs.getInt('minutes') ?? 59;
      _seconds = prefs.getInt('seconds') ?? 59;
    });
  }

  Future<void> _saveTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('hours', _hours);
    prefs.setInt('minutes', _minutes);
    prefs.setInt('seconds', _seconds);
  }

  Future<void> resetTimer() async {
    setState(() {
      _hours = 23;
      _minutes = 59;
      _seconds = 59;
    });
    _saveTime();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is resumed, restart the timer
      _loadSavedTime();
      _startTimer();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        '$_hours:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formattedTime,
          style: TextStyle(
              fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
