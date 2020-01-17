import 'dart:async';

import 'package:golden_clock/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

class AwesomeClock extends StatefulWidget {
  const AwesomeClock(this.model);

  final ClockModel model;

  @override
  _AwesomeClockState createState() => _AwesomeClockState();
}

class _AwesomeClockState extends State<AwesomeClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  var _temperature = '';
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';

  var _qoutes = {
    'cloudy': 'Even on a cloudy day the blue sky is still there',
    "foggy":
        "Sometimes we need the fod to remind ourselves that all of life is not black and white.",
    "rainy": "The sound of the rain needs no translation.",
    "snowy": "Snow is like kindness . beautfies everything he covers.",
    "sunny": "I find my happiness where the sun shines",
    "thunderstorm":
        "When you come out of the storm you won't be the same person that walked in.",
    "windy": "I love windy days they make me feel like i'm flying"
  };

  // List weekDays = [
  //   "Monday",
  //   "Tuesday",
  //   "Wednesday",
  //   "Thursday",
  //   "Friday",
  //   "Saturday",
  //   "Sunday",
  // ];
  List weekDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  static var selected_quote = '';

  var macolor = Color(0xFFffeb3b); // #ffcc33
  var today;
  @override
  void initState() {
    super.initState();

    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
    setState(() {
      today = DateFormat('E').format(_dateTime);
    });
  }

  @override
  void didUpdateWidget(AwesomeClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
      _temperature = widget.model.temperatureString;
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      selected_quote = _condition;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime, // #FF1F1F #0C72B3
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final themecolor = Theme.of(context).brightness == Brightness.light
        ? Helper.darkTheme
        : Helper.darkTheme;

    final reverseBGcolor = themecolor == Helper.lightTheme
        ? Helper.dark_bg_color
        : Helper.light_bg_color;

    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);

    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);

    return Container(
      color: reverseBGcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _temperature,
                        style: TextStyle(
                          color: themecolor[Helper.selected_bg_color],
                          fontFamily: Helper.font,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _condition,
                        style: TextStyle(
                          color: themecolor[Helper.selected_bg_color],
                          fontFamily: Helper.font,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Container(
                decoration: BoxDecoration(
                  color: themecolor[Helper.selected_bg_color],
                  // border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(7, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            weekDays[index],
                            style: today == weekDays[index]
                                ? Helper.awesometextStyle(themecolor, 10.0)
                                : TextStyle(
                                    fontFamily: 'CodaCaption',
                                    fontSize: 10,
                                    color:
                                        themecolor[Helper.selected_text_color]
                                            .withOpacity(.5),
                                  ),
                          ),
                        );
                      }).toList(),
                    ),
                    Center(
                      // color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(hour + ":",
                              style: Helper.awesometextStyle(themecolor, 80.0)),
                          Text(minute + ":",
                              style: Helper.awesometextStyle(themecolor, 80.0)),
                          Text(second,
                              style: Helper.awesometextStyle(themecolor, 80.0)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _qoutes[_condition],
                        style: Helper.awesometextStyle(themecolor, 10.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
