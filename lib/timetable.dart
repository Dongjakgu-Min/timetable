import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  final List<String> week = ["월", "화", "수", "목", "금", "토", "일", " "];

  List<Widget> dayWork(int weekIdx) {
    return [
      SizedBox(
          height: 20,
          child: Center(
            child: Text(
              week[weekIdx],
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          )),
      ...List.generate(20, (index) {
        if (index % 2 == 0) {
          return const Divider(
            height: 0,
            color: Colors.grey,
          );
        }
        if (weekIdx == 7) {
          return SizedBox(
            height: 50,
            child: Text(
              (index / 2).round().toString(),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          );
        }
        return Container(
          height: 50,
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
                      children: [...dayWork((index / 2).round() - 1)],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
