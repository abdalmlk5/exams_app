import 'package:exams_app/features/questions/presentation/pages/question_page.dart';
import 'package:flutter/material.dart';

class MainPageTest extends StatelessWidget {
  const MainPageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const QuestionPage(examId: '670070a830a3c3c1944a9c63'),
              ),
            );
          },
          child: const Text('Start Exam'),
        ),
      ),
    );
  }
}
