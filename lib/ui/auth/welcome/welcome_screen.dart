import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/ui/widgets/universal_widget/custom_button.dart';

import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundSmall),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    name: 'Login',
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.login);
                    },
                  ),
                  SizedBox(height: 15.h),
                  CustomButton(
                    outline: true,
                    name: 'Register',
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.signup);
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Continue as a guest',
                style: AppStyle.subtitle2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
