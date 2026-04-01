import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class QuestionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String time; // formatted (mm:ss)

  const QuestionsAppBar({super.key, required this.title, required this.time});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    int remainingSeconds = 60;
    try {
      final parts = time.split(':');
      if (parts.length >= 2) {
        remainingSeconds =
            (int.tryParse(parts[0]) ?? 0) * 60 + (int.tryParse(parts[1]) ?? 0);
      }
    } catch (_) {}

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Exit Exam"),
                content: const Text(
                  "Are you sure you want to leave? Your progress may be lost.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // exit exam page
                    },
                    child: const Text(
                      "Exit",
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      title: Text(title, style: AppStyles.black18500),
      backgroundColor: AppColors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SizedBox(
              width: 90,
              child: Text(
                "⏰ $time",
                style: remainingSeconds <= 1800
                    ? AppStyles.timerRed
                    : AppStyles.timerGreen,
              ),
            ),
          ),
        ),
      ],
      toolbarHeight: 60,
    );
  }
}
