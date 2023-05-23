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
        useMaterial3: true,
      ),
      home: const LimeScreen(
        title: 'Lime Consumption Calculator',
      ),
    );
  }
}

class LimeScreen extends StatefulWidget {
  const LimeScreen({super.key, required this.title});

  final String title;

  @override
  State<LimeScreen> createState() => _LimeScreenState();
}

class _LimeScreenState extends State<LimeScreen> {
  List<TimeEntry> timeEntries = [];
  List<int> limeWeightEntries = [];
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _limeWightController = TextEditingController();
  int? editingIndex;

  int get limeWeight => int.tryParse(_limeWightController.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(
              'Total Duration: ${formatDuration(totalDuration())}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // Text('Total Duration $totalDuration()'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _startTimeController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Start Time',
                      hintText: '00:00',
                      prefixIcon: IconButton(
                        onPressed: () {
                          timePicker(context, _startTimeController);
                        },
                        icon: const Icon(Icons.access_time),
                      ),
                    ),
                    onTap: () => _startTimeController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _endTimeController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'End Time',
                      hintText: '23:59',
                      prefixIcon: IconButton(
                        onPressed: () {
                          timePicker(context, _endTimeController);
                        },
                        icon: const Icon(Icons.access_time_filled),
                      ),
                    ),
                    onTap: () => _endTimeController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _limeWightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Lime Weight',
                      hintText: 'Weight in Tonns',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print(limeWeightEntries);
                print(timeEntries);
                if (editingIndex != null) {
                  _updateEntries(editingIndex!);
                }
                _addEntries();
              },
              child: Text(editingIndex != null ? 'Update' : 'Calculate'),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: timeEntries.length,
              itemBuilder: (context, index) {
                final timeEntry = timeEntries[index];
                final limeEntry = limeWeightEntries[index];
                return ListTile(
                  title: Row(
                    children: [
                      Text(timeEntry.startTime),
                      const SizedBox(width: 10),
                      const Text('-'),
                      const SizedBox(width: 10),
                      Text(timeEntry.endTime),
                      const SizedBox(width: 30),
                      Text(limeEntry.toString()),
                    ],
                  ),
                  trailing: Text(
                      '${timeEntry.duration.inHours} hours ${timeEntry.duration.inMinutes.remainder(60)} minutes'),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  // dispose all inputs
  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _limeWightController.dispose();
    super.dispose();
  }

  // method for time picker
  Future<void> timePicker(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: controller == _startTimeController
          ? const TimeOfDay(hour: 00, minute: 00)
          : const TimeOfDay(hour: 00, minute: 00),
    );
    if (pickedTime != null) {
      if (controller == _startTimeController) {
        controller.text = DateFormat.Hm().format(
          DateTime(2023, 1, 1, pickedTime.hour, pickedTime.minute),
        );
      } else {
        controller.text = DateFormat.Hm().format(
          DateTime(2023, 1, 2, pickedTime.hour, pickedTime.minute),
        );
      }
    }
  }

  Future<void> selectTime(TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
    if (pickedTime != null) {
      controller.text = DateFormat.Hm().format(
        DateTime(2023, 1, 1, pickedTime.hour, pickedTime.minute),
      );
    }
  }

  // method to calculate total duration
  Duration totalDuration() {
    Duration duration = const Duration();
    for (var entry in timeEntries) {
      duration += entry.duration;
    }
    return duration;
  }

  // format of duration
  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return '$hours:$minutes Hours';
  }

  // method to add time entries to empty list of timeEntries
  void _addEntries() {
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;
    final lime = limeWeight;

    if (startTime.isNotEmpty && endTime.isNotEmpty) {
      setState(() {
        timeEntries.add(TimeEntry(startTime: startTime, endTime: endTime));
        limeWeightEntries.add(lime);
      });
      _startTimeController.clear();
      _endTimeController.clear();
      _limeWightController.clear();
    }
  }

  void _updateEntries(int index) {
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;
    final lime = limeWeight;

    if (startTime.isNotEmpty && endTime.isNotEmpty) {
      setState(() {
        timeEntries[index] = TimeEntry(startTime: startTime, endTime: endTime);
        limeWeightEntries[index] = lime;

        editingIndex = null;
        _startTimeController.clear();
        _endTimeController.clear();
        _limeWightController.clear();
      });
    }
  }

  void _deleteTimeEntry(int index) {
    setState(() {
      timeEntries.removeAt(index);
    });
  }

  void _editTimeEntry(int index) {
    final timeEntry = timeEntries[index];
    setState(() {
      editingIndex = index;
      _startTimeController.text = timeEntry.startTime;
      _endTimeController.text = timeEntry.endTime;
    });
  }
}

class TimeEntry {
  final String startTime;
  final String endTime;

  TimeEntry({required this.startTime, required this.endTime});

  Duration get duration {
    final startDateTime = DateFormat.Hm().parse(startTime);
    final endDateTime = DateFormat.Hm().parse(endTime);
    return endDateTime.difference(startDateTime);
  }

  // Duration get reverseDuration {
  //   final startDateTime = DateFormat.Hm().parse(startTime);
  //   final endDateTime = DateFormat.Hm().parse(endTime);
  //   return startDateTime.difference(endDateTime);
  // }
}
