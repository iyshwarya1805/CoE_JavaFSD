import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/exercise_model.dart';

class ExerciseTimerPage extends StatefulWidget {
  final Exercise exercise;

  const ExerciseTimerPage({Key? key, required this.exercise}) : super(key: key);

  @override
  _ExerciseTimerPageState createState() => _ExerciseTimerPageState();
}

class _ExerciseTimerPageState extends State<ExerciseTimerPage> {
  int _remainingTime = 0;
  late Timer _timer;
  bool _isTimerRunning = false;
  List<int> _exerciseDurations = [];

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.exercise.defaultDuration;
  }

  void _startTimer() {
    if (!_isTimerRunning) {
      _isTimerRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
          });
        } else {
          _timer.cancel();
          _isTimerRunning = false;
          _showCompletionDialog();
        }
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exercise Completed'),
          content: Text('Great job completing ${widget.exercise.name}!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Save exercise duration to Firestore
                _saveExerciseDuration();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveExerciseDuration() async {
    try {
      // Add current exercise duration to the list
      _exerciseDurations.add(widget.exercise.defaultDuration);

      // Calculate total exercise time
      int totalExerciseTime = _exerciseDurations.reduce((a, b) => a + b);

      // Save to Firestore
      await FirebaseFirestore.instance.collection('exercise_logs').add({
        'exerciseName': widget.exercise.name,
        'duration': widget.exercise.defaultDuration,
        'totalExerciseTime': totalExerciseTime,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving exercise duration: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Timer'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.exercise.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _remainingTime / widget.exercise.defaultDuration,
                    strokeWidth: 15,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                Text(
                  '$_remainingTime',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Start Timer',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}