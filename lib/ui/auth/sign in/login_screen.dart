import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/provider/auth_provider.dart';
import 'package:ikea_store/ui/widgets/auth_widgets/custom_back_button.dart';
import 'package:ikea_store/ui/widgets/auth_widgets/registration_widgets.dart';
import 'package:ikea_store/ui/widgets/social_media/social_media_button.dart';
import 'package:ikea_store/ui/widgets/social_media/social_media_widget.dart';
import 'package:ikea_store/ui/widgets/universal_widget/custom_button.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomBackButton(
                onTap: () {
                  Navigator.pushReplacementNamed(context, RouteNames.welcome);
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
              RegistrationPart(
                emailChanged: (value) {
                  provider.email = value;
                },
                passwordChanged: (value) {
                  provider.password = value;
                },
              ),
              SizedBox(height: 48.h),
              CustomButton(
                name: 'Login',
                onTap: () {
                  provider.login(context);
                },
              ),
              SizedBox(height: 30.h),
              SocialMediaPart(
                socialMediaButtons: [
                  SocialMediaButton(
                    url: AppImages.facebook,
                  ),
                  SocialMediaButton(
                    url: AppImages.google,
                    onTap: () {
                      provider.loginWithGoogle(context);
                    },
                  ),
                  SocialMediaButton(url: AppImages.apple),
                ],
              ),
              SizedBox(height: 83.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouteNames.signup);
                  },
                  child: Text(
                    'Don’t have an account? Register Now',
                    style: AppStyle.subtitle2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
