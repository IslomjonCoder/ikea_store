import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/provider/auth_provider.dart';
import 'package:ikea_store/provider/home_provider.dart';
import 'package:ikea_store/provider/products_provider.dart';
import 'package:ikea_store/ui/admin/product/controller/products_controller.dart';
import 'package:ikea_store/ui/router.dart';
import 'package:ikea_store/utils/colors.dart';

import 'package:ikea_store/utils/routes.dart';
import 'package:ikea_store/utils/style.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const RouterApp(),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.white,
              centerTitle: true,
              titleTextStyle: AppStyle.subtitle1.copyWith(fontWeight: FontWeight.w700),
              // elevation: 0,
            ),
          ),
          onGenerateRoute: AppRoutes.generateRoute,
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
