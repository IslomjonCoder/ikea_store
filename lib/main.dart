import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ikea_store/ui/auth/provider/auth_provider.dart';
import 'package:ikea_store/ui/auth/welcome/welcome_screen.dart';
import 'package:ikea_store/ui/router.dart';
import 'package:ikea_store/utils/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RouterApp(),
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
