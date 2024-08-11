import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/src/screens/schedule_add.dart';
import 'package:timetable/src/widgets/timetable.dart';
import '../widgets/time_picker.dart';
import '../providers/timetable_provider.dart';
import '../models/schedule_item.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<ScheduleItem> _scheduleList = [];

  void _handleTimeSelected(ScheduleItem schedule) {
    setState(() {
      _scheduleList = [..._scheduleList, schedule];
    });
  }

  void _showAddScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('수업 추가'),
          content: TimePickerWidget(onTimeSelected: _handleTimeSelected),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('시간표'),
      ),
      body: const Column(
        children: [
          SafeArea(
            child: Column(
              children: [Timetable()],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('과목 추가'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduleAddScreen(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
