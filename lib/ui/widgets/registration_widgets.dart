import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/ui/auth/sign%20in/login_screen.dart';
import 'package:ikea_store/ui/widgets/forget_button.dart';
import 'package:ikea_store/ui/widgets/universal_input_widget.dart';

class RegistrationPart extends StatelessWidget {
  RegistrationPart({
    super.key,
    this.emailChanged,
    this.passwordChanged,
  });

  ValueChanged? emailChanged;
  ValueChanged? passwordChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UniversalInputWidget(
          hintText: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
          onChanged: emailChanged,
        ),
        SizedBox(height: 15.h),
        UniversalInputWidget(
          hintText: 'Enter your password',
          isSecure: true,
          onChanged: passwordChanged,
        ),
        const ForgetButton()
      ],
    );
  }
}
