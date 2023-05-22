import 'package:intl/intl.dart';

class TimeEntry {
  final String startTime;
  final String endTime;

  TimeEntry({required this.startTime, required this.endTime});

  Duration get duration {
    final startDateTime = DateFormat.Hm().parse(startTime);
    final endDateTime = DateFormat.Hm().parse(endTime);
    return endDateTime.difference(startDateTime);
  }

  Duration get reverseDuration {
    final startDateTime = DateFormat.Hm().parse(startTime);
    final endDateTime = DateFormat.Hm().parse(endTime);
    return startDateTime.difference(endDateTime);
  }
}
