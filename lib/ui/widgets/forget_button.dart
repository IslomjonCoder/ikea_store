import 'package:flutter/material.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/style.dart';

class ForgetButton extends StatelessWidget {
  const ForgetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () {},
          child: Text(
            'Forgot Password?',
            textAlign: TextAlign.right,
            style: AppStyle.body2.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.c6A707C),
          )),
    );
  }
}
