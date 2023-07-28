import 'package:flutter/material.dart';
import 'package:ikea_store/ui/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: TextButton(
            onPressed: () {
              provider.logout(context);
            },
            child: Text('Logout')),
      ),
    );
  }
}
