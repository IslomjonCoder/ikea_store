import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/style.dart';

class Diveder extends StatelessWidget {
  const Diveder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.cE8ECF4,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Text(
            'Or Login with',
            style: AppStyle.body2.copyWith(
                color: AppColors.c6A707C, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.cE8ECF4,
          ),
        ),
      ],
    );
  }
}
