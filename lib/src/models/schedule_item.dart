import 'package:flutter/material.dart';

class ScheduleItem {
  final String subject;
  final String professor;
  final String location;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  ScheduleItem({
    required this.subject,
    required this.professor,
    required this.location,
    required this.startTime,
    required this.endTime,
  });
}