import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ikea_store/ui/auth/auth/auth.dart';
import 'package:ikea_store/ui/auth/provider/auth_provider.dart';
import 'package:ikea_store/ui/auth/sign%20in/login_screen.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
