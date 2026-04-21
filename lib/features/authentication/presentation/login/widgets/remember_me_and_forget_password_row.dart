import 'package:exams_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMeAndForgetPasswordRow extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RememberMeAndForgetPasswordRow({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<RememberMeAndForgetPasswordRow> createState() =>
      _RememberMeAndForgetPasswordRowState();
}

class _RememberMeAndForgetPasswordRowState
    extends State<RememberMeAndForgetPasswordRow> {
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: Checkbox(value: widget.value, onChanged: widget.onChanged),
            ),
            SizedBox(width: 8.w),
            Text(AppStrings.rememberMe, style: theme.textTheme.bodyMedium),
          ],
        ),
        TextButton(
          onPressed: () {
            // i will navigate when i merge with the rest of the feature
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            AppStrings.forgetPasswordQuestion,
            style: theme.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
