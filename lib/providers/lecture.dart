import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lecture with ChangeNotifier {
  final Map<String, double> _tableVariables = {
    "CellHeight": 60,
    "HeaderCellHeight": 20,
    "TimeCellHeight": 20,
    "TableLength": 10,
    "TimeCellWidth": 20,
    "WeekDays": 5,
  };

  final Map<int, List<Widget>> _workBlock = {
    0: [],
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
  };

  Map<int, List<Widget>> get data => _workBlock;

  void add(int time, Widget lecture) {
    _workBlock[time]!.add(lecture);
    notifyListeners();
  }
}
