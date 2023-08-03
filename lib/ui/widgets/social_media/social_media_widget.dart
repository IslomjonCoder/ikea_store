import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/ui/widgets/social_media/social_media_divider.dart';

class SocialMediaPart extends StatelessWidget {
  SocialMediaPart({
    required this.socialMediaButtons,
    super.key,
  });
  List<Widget> socialMediaButtons;
  @override
  Widget build(BuildContext context) => Column(
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
