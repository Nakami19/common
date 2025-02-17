import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../common_index.dart';


class CountdownTimer extends StatefulWidget {
  final int duration;
  final double? radius;
  final Function callback;
  final GeneralProvider provider;
  final IconData? icon;
  final double? iconSize;
  final bool startTimer;

  const CountdownTimer({
    super.key,
    required this.duration,
    required this.callback,
    required this.provider,
    this.icon,
    this.radius,
    this.iconSize,
    this.startTimer = true,
  });

  @override
   State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _timeRemaining;
  late Timer _timer;

  // Controla si el timer está en ejecución
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
      _timeRemaining = widget.duration;
      _timer = Timer(Duration.zero, () {});
    if (widget.startTimer) {
      _startTimer();
      _isTimerRunning = true;
    }
    
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining == 0) {
        timer.cancel();
        setState(() {
          _isTimerRunning = false;
        });
      } else {
        setState(() {
          _timeRemaining--;
        });
      }
    });
  }

  void _resetTimer() {
  // Cancelar antes de reiniciar  
  if (_timer.isActive) {
    _timer.cancel(); 
  }
  setState(() {
    _timeRemaining = widget.duration;
    _startTimer();
    _isTimerRunning = true;
  });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme.bodySmall;
    return (_isTimerRunning &&  _timeRemaining > 0)
        ? CircularPercentIndicator(
            progressColor: colors.primary,
            radius: widget.radius ?? 20,
            lineWidth: 2.5,
            percent: _timeRemaining / widget.duration,
            center: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1), (value) {
                return (value);
              }).takeWhile((value) => value < _timeRemaining),
              builder: (context, snapshot) {
                return Center(
                  child: Text(
                    _timeRemaining.toString(),
                    style: textTheme!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          )
        : GestureDetector(
            child: Icon(
              widget.icon ?? Icons.autorenew,
              size: widget.iconSize??20,
              color: colors.primary,
            ),
            onTap: () async {
              if (!widget.provider.haveErrors) {
                await widget.callback();

                _resetTimer();
               
              }
            },
          );
  }
}
