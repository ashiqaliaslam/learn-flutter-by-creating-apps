import 'package:flutter/material.dart';
import 'package:lime_consumption/time_entry.dart';

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
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  // final TextEditingController
  int? editingIndex;

  void _timeEntry() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const TimeEntryScreen();
      },
    );
  }

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
              'Total Duration: 69:69 Hours',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _startTimeController,
                keyboardType: TextInputType.datetime,
                // decoration: InputDecoration(border: InputBorder(borderSide: BorderSide.strokeAlignCenter)),
                decoration: InputDecoration(
                    labelText: 'Start Time',
                    hintText: '00:00',
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.access_time),
                    )),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _timeEntry,
        tooltip: 'Add Data',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TimeEntryScreen extends StatefulWidget {
  const TimeEntryScreen({super.key});

  @override
  State<TimeEntryScreen> createState() => _TimeEntryScreenState();
}

class _TimeEntryScreenState extends State<TimeEntryScreen> {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController limeWeightController = TextEditingController();

  @override
  void dispose() {
    startTimeController.dispose();
    endTimeController.dispose();
    limeWeightController.dispose();
    super.dispose();
  }

  Future<void> timePicker(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(
        () {
          controller.text = pickedTime.format(context);
        },
      );
    }
  }

  void _addTimeEntry() {
    final startTime = startTimeController.text;
    final endTime = endTimeController.text;

    if (startTime.isNotEmpty && endTime.isNotEmpty) {
      setState(() {
        // TODO: add function to add entries to TimeEntry
        // timeEntries.add(TimeEntry(startTime: startTime, endTime: endTime)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: startTimeController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              labelText: 'Start Time',
              hintText: '00:00',
              prefixIcon: IconButton(
                onPressed: () {
                  timePicker(context, startTimeController);
                },
                icon: const Icon(Icons.access_time),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: endTimeController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              labelText: 'End Time',
              hintText: '00:00',
              prefixIcon: IconButton(
                onPressed: () {
                  timePicker(context, endTimeController);
                },
                icon: const Icon(Icons.access_time),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: limeWeightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Lime Weight',
              hintText: 'Weight in Tonns',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Add'),
        ),
      ],
    );
  }
}
