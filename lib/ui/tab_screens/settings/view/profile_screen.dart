import 'package:flutter/material.dart';
import 'package:ikea_store/provider/auth_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              provider.logout(context);
            },
            icon: SvgPicture.asset(AppImages.logout),
            padding: const EdgeInsets.all(16),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      child: (provider.user?.photoURL == null)
                          ? null
                          : Image.network(
                              provider.user!.photoURL!,
                            ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.user?.displayName ?? '',
                        style: AppStyle.title,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        provider.user?.email ?? '',
                        style: AppStyle.body2.copyWith(color: AppColors.c808080),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SettingCardWidget(
                title: 'Setting',
                subtitle: 'Notification, Password, FAQ, Contact',
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.setting);
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class SettingCardWidget extends StatelessWidget {
  SettingCardWidget({
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  String title;
  String subtitle;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Container(
        alignment: Alignment.center,
        height: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: AppColors.shadowColor, blurRadius: 40, offset: const Offset(0, 7))
          ],
          color: AppColors.white,
        ),
        child: ListTile(
          onTap: onTap,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyle.title.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: AppStyle.caption.copyWith(color: AppColors.c808080),
              ),
            ],
          ),
          trailing: IconButton(onPressed: () {}, icon: SvgPicture.asset(AppImages.arrowRight)),
        ),
      ),
    );
  }
}
