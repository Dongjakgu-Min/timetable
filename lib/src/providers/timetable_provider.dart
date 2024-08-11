import 'package:flutter/material.dart';
import 'package:timetable/src/models/schedule_item.dart';


class TimetableProvider with ChangeNotifier {
  final Map<String, double> tableVariables = {
    "CellHeight": 60,
    "HeaderCellHeight": 20,
    "TimeCellHeight": 20,
    "TableLength": 10,
    "TimeCellWidth": 20,
    "WeekDays": 5,
  };

  Map<String, List<ScheduleItem>> timetable = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
    'Sunday': [],
  };

  void addScheduleItem(String day, ScheduleItem item) {
    if (_isTimeOverlapping(day, item)) {
      print('Schedule overlaps with an existing schedule.');
    } else {
      timetable[day]?.add(item);
      notifyListeners();
    }
  }

  void removeScheduleItem(String day, ScheduleItem item) {
    timetable[day]?.remove(item);
    notifyListeners();
  }

  List<ScheduleItem>? getScheduleForDay(String day) {
    return timetable[day];
  }

  bool _isTimeOverlapping(String day, ScheduleItem newItem) {
    for (ScheduleItem existingItem in timetable[day]!) {
      if (_timeRangesOverlap(
        existingItem.startTime,
        existingItem.endTime,
        newItem.startTime,
        newItem.endTime,
      )) {
        return true;
      }
    }
    return false;
  }

  bool _timeRangesOverlap(
      TimeOfDay startTime1, TimeOfDay endTime1, TimeOfDay startTime2, TimeOfDay endTime2) {
    final start1 = Duration(hours: startTime1.hour, minutes: startTime1.minute);
    final end1 = Duration(hours: endTime1.hour, minutes: endTime1.minute);
    final start2 = Duration(hours: startTime2.hour, minutes: startTime2.minute);
    final end2 = Duration(hours: endTime2.hour, minutes: endTime2.minute);

    // 시간이 겹치는지 확인하는 로직
    return (start1 < end2 && end1 > start2);
  }
}
