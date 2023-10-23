import 'dart:core';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key, required this.workBlock}) : super(key: key);
  final Map<int, List<Widget>> workBlock;

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  final List<String> week = ["월", "화", "수", "목", "금", "토", "일", " "];
  final Map<String, double> _tableVariables = {
    "CellHeight": 60,
    "HeaderCellHeight": 20,
    "TimeCellHeight": 20,
    "TableLength": 10,
    "TimeCellWidth": 20,
    "WeekDays": 5,
  };

  List<Widget> _buildDay() {
    return [
      ...List.generate(5 * 2, (index) {
        if (index % 2 == 0) {
          return const VerticalDivider(
            color: Colors.grey,
            width: 0,
          );
        }
        return Expanded(
          flex: 4,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...dayWork((index / 2).round() - 1),
                ],
              ),
              ...?widget.workBlock[(index / 2).round() - 1],
            ],
          ),
        );
      }),
    ];
  }

  List<Widget> dayWork(int weekIdx) {
    return [
      SizedBox(
          height: _tableVariables["HeaderCellHeight"],
          child: Center(
            child: Text(
              week[weekIdx],
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          )),
      ...List.generate(_tableVariables["TableLength"]!.round() * 2, (index) {
        if (index % 2 == 0) {
          return const Divider(
            height: 0,
            color: Colors.grey,
          );
        }
        if (weekIdx == 7) {
          return SizedBox(
            height: _tableVariables["CellHeight"],
            child: Text(
              (index / 2).round().toString(),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          );
        }
        return Container(
          height: _tableVariables["CellHeight"],
        );
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [...dayWork(7)],
              ),
            ),
            ..._buildDay(),
          ],
        ),
      ),
    );
  }
}
