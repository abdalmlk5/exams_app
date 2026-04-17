import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const AuthAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: onBack != null
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.iconTheme.color,
                size: 20.sp,
              ),
              onPressed: onBack,
            )
          : null,
      title: Text(
        title,
        style: theme.textTheme.displayLarge,
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
