import 'package:flutter/material.dart';
import 'package:ikea_store/ui/widgets/custom_button.dart';

import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/style.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.backgroundSmall),
                fit: BoxFit.cover)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    name: 'Login',
                  ),
                  CustomButton(
                    outline: true,
                    name: 'Register',
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Continue as a guest',
                  style: AppStyle.subtitle2,
                ))
          ],
        ),
      ),
    );
  }
}
