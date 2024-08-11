import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timetable_provider.dart';
import '../models/schedule_item.dart';

class DayScheduleWidget extends StatelessWidget {
  final String day;

  const DayScheduleWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimetableProvider>(
      builder: (context, provider, child) {
        final List<ScheduleItem> items = provider.timetable[day] ?? [];

        return ExpansionTile(
          title: Text(day),
          children: items.isEmpty
              ? [ListTile(title: Text('No schedules for this day'))]
              : items.map((item) {
                  return ListTile(
                    title: Text(item.subject),
                    subtitle: Text(
                      '${item.startTime.format(context)} - ${item.endTime.format(context)}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        provider.removeScheduleItem(day, item);
                      },
                    ),
                  );
                }).toList(),
        );
      },
    );
  }
}