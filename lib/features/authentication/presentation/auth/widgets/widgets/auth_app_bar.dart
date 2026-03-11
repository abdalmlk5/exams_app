import 'package:exams_app/core/utils/app_text_styles.dart';
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
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.arrow_back_ios,
      //     color: Colors.black,
      //     size: 20.sp,
      //   ),
      //        onPressed: (){},
      // ),
      title: Text(
        title,
        style: AppTextStyles.black18500,
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
