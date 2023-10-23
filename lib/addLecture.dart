import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timetable/timetable.dart';

class LectureAddScreen extends StatefulWidget {
  const LectureAddScreen({Key? key, required this.workBlock}) : super(key: key);
  final Map<int, List<Widget>> workBlock;

  @override
  State<StatefulWidget> createState() => _LectureAddScreenState();
}

class _LectureAddScreenState extends State<LectureAddScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("시간표"),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0.0),
          onPressed: null,
          child: Text(
            "추가",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        leading: CupertinoButton(
            padding: EdgeInsets.all(0.0),
            child: Text("안녕"),
            onPressed: () => {Navigator.pop(context)}),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Timetable(
                    workBlock: widget.workBlock,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade100,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        _inputTextWidget("과목명"),
                        Divider(
                          color: Colors.grey.shade200,
                          thickness: 1,
                        ),
                        _inputTextWidget("장소"),
                        Divider(
                          color: Colors.grey.shade200,
                          thickness: 1,
                        ),
                        _inputTextWidget("교수자"),
                        Divider(
                          color: Colors.grey.shade200,
                          thickness: 1,
                        ),
                        _inputTextWidget("시간"),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    child: SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        onPressed: () => {},
                        color: Colors.blue,
                        child: const Text("추가"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputTextWidget(String title) {
    return CupertinoTextField(
      prefix: SizedBox(
        width: 50,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: const BoxDecoration(),
    );
  }
}
