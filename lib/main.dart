import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/timetable_provider.dart';
import 'src/screens/schedule_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimetableProvider(),
      child: MaterialApp(
        title: 'Timetable App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const ScheduleScreen(),
      ),
    );
  }
}