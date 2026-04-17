import 'package:exams_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class QuestionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String time; // formatted (mm:ss)
  final int remainingSeconds;
  final int totalSeconds;

  const QuestionsAppBar({
    super.key,
    required this.title,
    required this.time,
    required this.remainingSeconds,
    required this.totalSeconds,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Color logic: Red if more than half the time has passed
    // elapsed = total - remaining
    // elapsed > total / 2  => total - remaining > total / 2 => total / 2 > remaining
    final bool isHalfTimePassed = remainingSeconds <= (totalSeconds / 2);

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Exit Exam", style: theme.textTheme.titleLarge),
                content: Text(
                  "Are you sure you want to leave? Your progress may be lost.",
                  style: theme.textTheme.bodyLarge,
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
                    child: Text(
                      "Exit",
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium!.copyWith(fontSize: 20),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SizedBox(
              width: 90,
              child: Text(
                "⏰ $time",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  color: isHalfTimePassed
                      ? theme.colorScheme.error
                      : AppColors.success,
                ),
              ),
            ),
          ),
        ),
      ],
      toolbarHeight: 60,
    );
  }
}
