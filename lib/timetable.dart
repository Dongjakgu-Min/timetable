import 'dart:core';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/main.dart';
import 'package:timetable/providers/lecture.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

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

  List<Widget> _buildDay(String title, Map<int, List<Widget>> works) {
    return [
      SizedBox(
        height: _tableVariables["HeaderCellHeight"],
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ),
      ...List.generate(5 * 2, (index) {
        return Expanded(
          flex: 4,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._dayWork((index / 2).round() - 1),
                ],
              ),
              ...?works[(index / 2).round() - 1],
            ],
          ),
        );
      }),
    ];
  }

  List<Widget> _tableTime() {
    return [
      SizedBox(
        height: _tableVariables["HeaderCellHeight"],
        child: const Center(
          child: Text(
            " ",
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ),
      ...List.generate(_tableVariables["TableLength"]!.round() * 2, (index) {
        if (index % 2 == 0) {
          return const Divider(
            height: 0,
            color: Colors.grey,
          );
        }

        return SizedBox(
          height: _tableVariables["CellHeight"],
          child: Text(
            (index / 2).round().toString(),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        );
      })
    ];
  }

  List<Widget> _dayWork(int weekIdx) {
    return [
      Container(
        height: _tableVariables["HeaderCellHeight"],
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            week[weekIdx],
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ),
      ...List.generate(_tableVariables["TableLength"]!.round() * 2, (index) {
        if (index % 2 == 0) {
          return const Divider(
            height: 0,
            color: Colors.grey,
          );
        }
        return Container(
          height: _tableVariables["CellHeight"],
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.grey,
                width: 0,
              ),
            ),
          ),
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
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._tableTime(),
              ],
            ),
          ),
          ...List.generate(
            _tableVariables["WeekDays"]!.round(),
            (index) => Expanded(
              child: Column(
                children: [..._dayWork(index)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
