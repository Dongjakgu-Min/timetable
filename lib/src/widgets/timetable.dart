import 'dart:core';

import 'package:flutter/material.dart';
import 'package:timetable/main.dart';
import 'package:provider/provider.dart';
import 'package:timetable/src/models/schedule_item.dart';
import 'package:timetable/src/providers/timetable_provider.dart';
import 'package:timetable/src/utils/table_variable.dart';
import 'package:timetable/src/widgets/time_block.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  final List<String> week = ["월", "화", "수", "목", "금", "토", "일", " "];
  final List<String> weekEng = [
    'Monday',
    'Tuseday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    ''
  ];

  List<Widget> _tableTime() {
    return [
      SizedBox(
        height: TableVariable().headerCellHeight,
        child: const Center(
          child: Text(
            " ",
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ),
      ),
      ...List.generate(TableVariable().tabLength.round() * 2, (index) {
        if (index % 2 == 0) {
          return const Divider(
            height: 0,
            color: Colors.grey,
          );
        }

        return SizedBox(
          height: TableVariable().cellHeight,
          child: Text(
            (index / 2).round().toString(),
            style: const TextStyle(fontSize: 13, color: Colors.black),
          ),
        );
      })
    ];
  }

  List<Widget> _dayWork(int weekIdx) {
    return [
      Container(
        height: TableVariable().headerCellHeight,
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey,
              width: 1,
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
      ...List.generate(TableVariable().tabLength.round() * 2, (index) {
        if (index % 2 == 0) {
          return const Divider(
            height: 0,
            color: Colors.grey,
          );
        }
        return Container(
          height: TableVariable().cellHeight,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.grey,
                width: 1,
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
            TableVariable().weekDays.round(),
            (index) => Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [..._dayWork(index)],
                  ),
                  ...context
                      .watch<TimetableProvider>()
                      .getScheduleForDay(weekEng[index])!
                      .map((elem) => TimeBlock(
                            day: weekEng[index],
                            lectureName: elem.subject,
                            professor: elem.professor,
                            startTime: elem.startTime,
                            endTime: elem.endTime,
                            location: elem.location,
                          ))
                      .toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
