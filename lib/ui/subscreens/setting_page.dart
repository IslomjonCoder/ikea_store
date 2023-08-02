import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikea_store/provider/auth_provider.dart';
import 'package:ikea_store/utils/colors.dart';
import 'package:ikea_store/utils/images.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    print(provider.user?.displayName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppImages.arrowBack)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: Column(
          children: [
            InfoWidget(
              provider: provider,
              title: 'Personal Information',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    provider.email = provider.user?.email ?? "";
                    provider.name = provider.user?.displayName ?? "";
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Personal information',
                                style: AppStyle.subhead,
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                initialValue: provider.user?.displayName ?? '',
                                onChanged: (value) {
                                  provider.name = value;
                                  print(provider.name);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Username',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                initialValue: provider.email,
                                onChanged: (value) => provider.email = value,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => provider.changeUserInfo(context),
                                  child: const Text('Update')))
                        ],
                      ),
                    );
                  },
                );
              },
              children: [
                InformationWidget(title: 'Name', body: provider.user?.displayName ?? ''),
                InformationWidget(title: 'Email', body: provider.user?.email ?? ''),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  InfoWidget({
    super.key,
    required this.provider,
    required this.title,
    required this.children,
    required this.onTap,
  });

  final AuthProvider provider;
  String title;
  List<Widget> children;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style:
                  AppStyle.subhead.copyWith(fontWeight: FontWeight.w600, color: AppColors.c909191),
            ),
            IconButton(onPressed: onTap, icon: SvgPicture.asset(AppImages.edit))
          ],
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: children.length)
      ],
    );
  }
}

class InformationWidget extends StatelessWidget {
  InformationWidget({
    super.key,
    required this.title,
    required this.body,
  });
  String title;
  String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 64,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: AppColors.shadowColor, offset: const Offset(0, 2), blurRadius: 40)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.caption.copyWith(color: AppColors.c808080),
          ),
          const SizedBox(height: 5),
          Text(
            body,
            style: AppStyle.body2.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
