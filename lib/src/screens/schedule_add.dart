import 'package:flutter/material.dart';
import 'package:timetable/src/models/schedule_item.dart';
import 'package:timetable/src/widgets/time_picker.dart';
import 'package:timetable/src/widgets/timetable.dart';

class ScheduleAddScreen extends StatefulWidget {
  const ScheduleAddScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleAddScreenState();
}

class _ScheduleAddScreenState extends State<ScheduleAddScreen> {
  List<ScheduleItem> _scheduleList = [];

  void _handleTimeSelected(ScheduleItem schedule) {
    setState(() {
      _scheduleList = [..._scheduleList, schedule];
    });
  }

// TODO: 두 Section 모두 스크롤 가능하도록
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일정 추가'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1, // 화면의 절반 차지
              child: SingleChildScrollView(
                child: Timetable(),
              ), // Timetable 위젯
            ),
            Expanded(
              flex: 1, // 화면의 절반 차지
              child: TimePickerWidget(
                onTimeSelected: _handleTimeSelected,
              ), // TimePicker 위젯
            ),
          ],
        ),
      ),
    );
  }
}
