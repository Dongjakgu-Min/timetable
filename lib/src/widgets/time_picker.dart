import 'package:flutter/material.dart';
import 'package:timetable/src/models/schedule_item.dart';
import 'package:provider/provider.dart';

class TimePickerWidget extends StatefulWidget {
  // final Function(TimeOfDay, TimeOfDay, String, String, String, List<String>) onTimeSelected;
  final Function(ScheduleItem) onTimeSelected;

  const TimePickerWidget({super.key, required this.onTimeSelected});

  @override
  State<TimePickerWidget> createState() {
    return _TimePickerWidgetState();
  }
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  final Map<String, TextEditingController> textController = {
    'subject': TextEditingController(),
    'professor': TextEditingController(),
    'location': TextEditingController(),
  };
  List<String> _selectedDays = [];
  TimeOfDay? _startTime, _endTime;

  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _showDayPickerDialog(BuildContext context) {
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];
    List<bool> isSelected = List.generate(daysOfWeek.length,
        (index) => _selectedDays.contains(daysOfWeek[index]));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('날짜 선택'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(daysOfWeek.length, (index) {
                  return CheckboxListTile(
                    title: Text(daysOfWeek[index]),
                    value: isSelected[index],
                    onChanged: (bool? value) {
                      setState(() {
                        isSelected[index] = value ?? false;
                      });
                    },
                  );
                }),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    _selectedDays = daysOfWeek
                        .asMap()
                        .entries
                        .where((entry) => isSelected[entry.key])
                        .map((entry) => entry.value)
                        .toList();
                    Navigator.of(context).pop();
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () => _showDayPickerDialog(context),
          child: Text(_selectedDays.isEmpty
              ? 'Select Days'
              : 'Selected Days: ${_selectedDays.join(', ')}'),
        ),
        ElevatedButton(
          onPressed: () => _selectStartTime(context),
          child: Text(_startTime == null
              ? 'Select Start Time'
              : 'Start Time: ${_startTime!.format(context)}'),
        ),
        ElevatedButton(
          onPressed: () => _selectEndTime(context),
          child: Text(_endTime == null
              ? 'Select End Time'
              : 'End Time: ${_endTime!.format(context)}'),
        ),
        TextField(
          controller: textController['subject'],
          decoration: const InputDecoration(hintText: '강의 이름'),
        ),
        TextField(
          controller: textController['professor'],
          decoration: const InputDecoration(hintText: '교수명'),
        ),
        TextField(
          controller: textController['location'],
          decoration: const InputDecoration(hintText: '위치'),
        ),
        ElevatedButton(
          onPressed: _startTime != null && _endTime != null
              ? () => widget.onTimeSelected(ScheduleItem(
                  subject: textController['subject']!.text,
                  professor: textController['professor']!.text,
                  location: textController['location']!.text,
                  startTime: _startTime!,
                  endTime: _endTime!))
              : null,
          child: const Text('일정 추가'),
        ),
      ],
    );
  }
}
