import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/ui/auth/sign%20in/login_screen.dart';
import 'package:ikea_store/ui/widgets/social_media/social_media_button.dart';
import 'package:ikea_store/ui/widgets/social_media/social_media_diveder.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/style.dart';

class SocialMediaPart extends StatelessWidget {
  SocialMediaPart({
    super.key,
    required this.socialMediaButtons,
  });
  List<Widget> socialMediaButtons;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Diveder(),
        SizedBox(height: 22.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: socialMediaButtons,
        ),
      ],
    );
  }
}
