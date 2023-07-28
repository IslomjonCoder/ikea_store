import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/utils/colors.dart';

class SocialMediaButton extends StatelessWidget {
  SocialMediaButton({
    super.key,
    required this.url,
    this.onTap,
  });

  String url;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105.w,
      height: 56.h,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: AppColors.cDADADA,
                  ))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(url),
          )),
    );
  }
}
