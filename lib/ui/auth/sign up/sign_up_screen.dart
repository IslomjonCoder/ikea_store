import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/ui/auth/provider/auth_provider.dart';
import 'package:ikea_store/ui/widgets/custom_back_button.dart';
import 'package:ikea_store/ui/widgets/custom_button.dart';
import 'package:ikea_store/ui/widgets/social_media/social_media_button.dart';
import 'package:ikea_store/ui/widgets/social_media/social_media_widget.dart';
import 'package:ikea_store/ui/widgets/universal_input_widget.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  CustomBackButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.welcome);
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Welcome back! Glad to see you, Again!',
                    style: AppStyle.display1.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 47.h),
                  UniversalInputWidget(
                    hintText: 'Username',
                    onChanged: (value) => provider.name = value,
                  ),
                  SizedBox(height: 15.h),
                  UniversalInputWidget(
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => provider.email = value,
                  ),
                  SizedBox(height: 15.h),
                  UniversalInputWidget(
                    hintText: 'Password',
                    isSecure: true,
                    onChanged: (value) => provider.password = value,
                  ),
                  SizedBox(height: 15.h),
                  UniversalInputWidget(
                    hintText: 'Confirm Password',
                    isSecure: true,
                    onChanged: (value) => provider.confirmPassword = value,
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    name: 'Agree and Register',
                    onTap: () {
                      provider.createAccount(context);
                    },
                  ),
                  SizedBox(height: 30.h),
                  SocialMediaPart(
                    socialMediaButtons: [
                      SocialMediaButton(url: AppImages.facebook),
                      SocialMediaButton(
                        url: AppImages.google,
                        onTap: () {
                          provider.loginWithGoogle(context);
                        },
                      ),
                      SocialMediaButton(url: AppImages.apple),
                    ],
                  ),
                ],
              ),
            ),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
