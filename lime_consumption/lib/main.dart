import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const LimeConsumptionCalculator());
}

class LimeConsumptionCalculator extends StatelessWidget {
  const LimeConsumptionCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        // primarySwatch: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const LCCHomePage(
        title: 'Calculate Lime Consumption',
      ),
    );
  }
}

class LCCHomePage extends StatefulWidget {
  const LCCHomePage({super.key, required this.title});

  final String title;

  @override
  State<LCCHomePage> createState() => _CounterAppHomePageState();
}

class _CounterAppHomePageState extends State<LCCHomePage> {
  // TimePickerEntryMode _selectStartTime = TimePickerEntryMode.dial;
  TimeOfDay _dayStartTime = TimeOfDay(hour: 00, minute: 00);

  // TextEditingController _timeController = TextEditingController();
  List<Duration> durations = [];
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController limeWeightInTonns = TextEditingController();

  @override
  void dispose() {
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  void addDurations() {
    final startTime = DateFormat.Hm().parse(startTimeController.text);
    final endTime = DateFormat.Hm().parse(endTimeController.text);

    setState(() {
      durations.add(endTime.difference(startTime));
      startTimeController.clear();
      endTimeController.clear();
    });
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    // final seconds = duration.inSeconds.remainder(60);
    return '$hours:$minutes Hours,';
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        startTimeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        endTimeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration totalDuration = durations.fold(
      const Duration(),
      (previousValue, element) => previousValue + element,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Text('okk'),
          TextField(
            controller: startTimeController,
            keyboardType: TextInputType.datetime,
            // enabled: false,
            decoration: InputDecoration(
              labelText: 'Lime Feeding Start Time',
              hintText: '00:00',
              prefixIcon: IconButton(
                onPressed: () => _selectStartTime(context),
                icon: const Icon(Icons.access_time),
              ),
            ),
          ),

          const SizedBox(height: 16),
          TextField(
            controller: endTimeController,
            keyboardType: TextInputType.datetime,
            // enabled: false,
            decoration: InputDecoration(
              labelText: 'Lime Feeding End Time',
              hintText: '00:00',
              prefixIcon: IconButton(
                onPressed: () => _selectEndTime(context),
                icon: const Icon(Icons.access_time),
              ),
            ),
          ),
          TextField(
            controller: limeWeightInTonns,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Lime Shifted in Tonns',
              hintText: '50',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: addDurations,
            child: const Text('Add Duration'),
          ),
          // final numbers = <double>[10, 2, 5, 0.5];
          // const initialValue =  Duration();
          // final result = numbers.fold<double>(
          //     initialValue, (previousValue, element) => previousValue + element);
          // print(result);
          Text(
            'Total Duration: ${formatDuration(
              durations.fold(
                  const Duration(), (prev, element) => prev + element),
            )}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(formatDuration(totalDuration)),
          Text(totalDuration.toString()),
          const SizedBox(height: 16),
          const Text(
            'Individual Durations:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: durations.length,
            itemBuilder: (context, index) {
              return Text(formatDuration(durations[index]));
            },
          ),
        ],
      ),
    );
  }
}
