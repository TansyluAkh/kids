import 'package:bebkeler/infrastructure/auth/auth_service.dart';
import 'package:bebkeler/ui/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/screens/home_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = AuthService.instance;
    if (authService.isAuthenticated) {
      return HomePage();
    } else {
      return AuthScreen();
    }
  }
}
