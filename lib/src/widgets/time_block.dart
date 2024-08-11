import 'package:flutter/material.dart';
import 'package:timetable/src/utils/table_variable.dart';

class TimeBlock extends StatelessWidget {
  const TimeBlock(
      {super.key,
      required this.lectureName,
      required this.professor,
      required this.location,
      required this.day,
      required this.startTime,
      required this.endTime});

  final String lectureName, professor, location, day;
  final TimeOfDay startTime, endTime;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TableVariable().headerCellHeight + (startTime.hour - 9) * 60 + startTime.minute,
      height: (endTime.hour * 60 +
              endTime.minute -
              (startTime.hour * 60 + startTime.minute))
          .toDouble(),
      width: TableVariable().timeCellWidth,
      child: Container(
        color: const Color.fromARGB(255, 182, 220, 238),
        // child: Column(
        //   children: [
        //     Text(lectureName),
        //     Text(professor),
        //     Text(location),
        //   ],
        // ),
      ),
    );
  }
}
