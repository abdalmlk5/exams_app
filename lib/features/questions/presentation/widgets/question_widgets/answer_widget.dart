import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final String text;
  final String value;
  final String? groupValue;
  final Function(String) onSelect;

  const AnswerWidget({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onSelect(value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors
                    .blue10 // light blue
              : AppColors.black5, // gray
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: (val) => onSelect(val!),
              activeColor: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: AppStyles.black13400)),
          ],
        ),
      ),
    );
  }
}
