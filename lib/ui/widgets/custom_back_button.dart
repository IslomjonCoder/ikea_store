import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/utils/colors.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({
    super.key,
    required this.onTap,
  });

  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 41.h,
        width: 41.w,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cE8ECF4)),
        child: const Icon(Icons.arrow_back, size: 19),
      ),
    );
  }
}
