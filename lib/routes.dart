import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/model/user.dart';
import 'package:totalx/screens/homescreen.dart';
import 'package:totalx/screens/login_screen.dart';
import 'package:totalx/services/auth_services.dart';

class Routes extends StatelessWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context);
    return StreamBuilder(
        stream: authService.user,
        builder: (_, AsyncSnapshot<UserDetails?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final UserDetails? user = snapshot.data;
            return user == null ? const LoginScreen() :const  HomeScreen();
          } else {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
