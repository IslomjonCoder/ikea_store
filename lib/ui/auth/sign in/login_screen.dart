import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/ui/auth/provider/auth_provider.dart';
import 'package:ikea_store/ui/auth/sign%20up/sign_up_screen.dart';
import 'package:ikea_store/ui/widgets/custom_button.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Text part for showing text
            Text(
              'Welcome back! Glad to see you, Again!',
              style: AppStyle.display1.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            // Register and forget password part

            // Login button part
            CustomButton(name: 'Login'),
            // Diveder part
            Diveder(),
            // Social media parts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialMediaWidget(url: AppImages.facebook),
                SocialMediaWidget(url: AppImages.google),
                SocialMediaWidget(url: AppImages.apple),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Don’t have an account? Register Now',
                  style: AppStyle.subtitle2,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.login),
      ),
    );
  }
}

class SocialMediaWidget extends StatelessWidget {
  SocialMediaWidget({
    super.key,
    required this.url,
  });

  String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      height: 56,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: AppColors.cDADADA,
                  ))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(url),
          )),
      decoration: BoxDecoration(),
    );
  }
}

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
          padding: const EdgeInsets.symmetric(horizontal: 6),
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
