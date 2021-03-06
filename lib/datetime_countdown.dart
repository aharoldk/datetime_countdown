library datetime_countdown;

import 'dart:async';

import 'package:flutter/material.dart';

class DateTimeCountDown extends StatefulWidget {
  final String expireAt;
  final String expiredText;
  final TextStyle textStyle;

  const DateTimeCountDown(
      {Key? key,
      required this.expireAt,
      this.expiredText = 'Time Expire',
      this.textStyle = const TextStyle(
          color: Color(0xFFeb0339), fontWeight: FontWeight.w700)})
      : super(key: key);

  @override
  State<DateTimeCountDown> createState() => _DateTimeCountDownState();
}

class _DateTimeCountDownState extends State<DateTimeCountDown> {
  Timer? timer;

  @override
  void initState() {
    timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  String _timeLeft(DateTime due) {
    String retVal = "";

    Duration _timeUntilDue = due.difference(DateTime.now());

    int _daysUntil = _timeUntilDue.inDays;
    int _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);
    int _minUntil =
        _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);
    int _secUntil = _timeUntilDue.inSeconds - (_minUntil * 60);

    String _second = _secUntil.toString().length <= 2
        ? _secUntil.toString().padLeft(2, '0')
        : _secUntil.toString().substring(_secUntil.toString().length - 2);
    String _minutes = _minUntil.toString().padLeft(2, '0');
    String _hours = _hoursUntil.toString().padLeft(2, '0');

    if (_secUntil > 0) {
      retVal = _second;
    }

    if (_minUntil > 0) {
      retVal = '$_minutes : $_second';
    }

    if (_hoursUntil > 0) {
      retVal = '$_hours : $_minutes : $_second';
    }

    return _hoursUntil < 1 && _minUntil < 1 && _secUntil < 1
        ? widget.expiredText
        : retVal;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeLeft(DateTime.parse(widget.expireAt)),
      style: widget.textStyle,
    );
  }
}
