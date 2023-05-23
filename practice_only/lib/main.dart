import 'package:flutter/material.dart';
import 'dart:core';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  // TimeOfDay? _startTime;
  // TimeOfDay? _endTime;

  final List<Duration> _durations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Start Time: ${_startTime.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? selectedStartTime = await showTimePicker(
                  context: context,
                  initialTime: _startTime,
                );
                if (selectedStartTime == null) return;
                setState(() {
                  _startTime = selectedStartTime;
                });
              },
              child: const Text('Select Start Time'),
            ),
            Text('End Time: ${_endTime.format(context)}'),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? selectedEndTime = await showTimePicker(
                  context: context,
                  initialTime: _endTime,
                );
                if (selectedEndTime == null) return;

                setState(() {
                  _endTime = selectedEndTime;
                });
              },
              child: const Text('Select End Time'),
            ),
            ElevatedButton(
              onPressed: () {
                DateTime dateTime1 =
                    DateTime(2022, 5, 15, _startTime.hour, _startTime.minute);
                DateTime dateTime2 =
                    DateTime(2022, 5, 16, _endTime.hour, _endTime.minute);
                Duration difference = dateTime1.difference(dateTime2);
                _durations.add(difference);
                // ignore: avoid_print
                print(difference);
              },
              child: const Text('Calculate Difference'),
            ),
            const Text('Durations:'),
            ListView.builder(
              itemCount: _durations.length,
              itemBuilder: (context, index) {
                return Text(
                    '${_durations[index].inHours} hours ${_durations[index].inMinutes} minutes');
              },
            ),
          ],
        ),
      ),
    );
  }
}
