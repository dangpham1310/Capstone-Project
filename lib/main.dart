import 'package:flutter/material.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/pages/authen_page.dart';
import 'package:project/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final apiKey = authService.getApiKey();

    if (apiKey != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      );
    }

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenPage(),
    );
  }
}
