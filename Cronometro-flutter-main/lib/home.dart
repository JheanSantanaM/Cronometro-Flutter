import 'dart:async';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isStart = true;
  String _stopwatchText = '00:00:00';

  final Stopwatch _stopWatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_stopWatch.isRunning) {
        setState(() {
          _setStopwatchText();
        });
      }
    });
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_stopWatch.isRunning) {
        _stopWatch.stop();
        _timer?.cancel();
        _isStart = true;
      } else {
        _stopWatch.start();
        _startTimer();
        _isStart = false;
      }
    });
  }

  void _resetButtonPressed() {
    _stopWatch.stop();
    _timer?.cancel();
    setState(() {
      _stopWatch.reset();
      _setStopwatchText();
      _isStart = true;
    });
  }

  void _setStopwatchText() {
    final elapsed = _stopWatch.elapsed;
    _stopwatchText =
        '${elapsed.inHours.toString().padLeft(2, '0')}:'
        '${(elapsed.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronômetro'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text(
              _stopwatchText,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _startStopButtonPressed,
              child: Icon(
                _isStart ? Icons.play_arrow : Icons.stop,
                size: 32,
              ),
            ),
            ElevatedButton(
              onPressed: _resetButtonPressed,
              child: const Text('Reset'),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
