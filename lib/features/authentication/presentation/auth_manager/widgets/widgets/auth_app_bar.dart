import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const AuthAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  State<AuthAppBar> createState() => _AuthAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

class _AuthAppBarState extends State<AuthAppBar> {
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: widget.onBack != null
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.iconTheme.color,
                size: 20.sp,
              ),
              onPressed: widget.onBack,
            )
          : null,
      title: Text(
        widget.title,
        style: theme.textTheme.displayLarge,
      ),
      centerTitle: false,
    );
  }
}
