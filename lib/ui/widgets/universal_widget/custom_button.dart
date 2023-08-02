import 'package:flutter/material.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/style.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.name,
    required this.onTap,
    this.outline = false,
    super.key,
  });

  final bool outline;
  String name;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 56,
        width: double.infinity,
        // margin: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: outline ? AppColors.white : AppColors.dark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: outline ? AppColors.dark : const Color(0xFF000000),
              ),
            ),
          ),
          child: Text(
            name,
            style: AppStyle.body1.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: outline ? AppColors.dark : AppColors.white,
            ),
          ),
        ),
      );
}
