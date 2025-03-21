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
    final token = authService.getToken();

    if (token != null) {
      if (authService.isTokenValid()) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      } else {
        return FutureBuilder<bool>(
          future: authService.refreshTokenIfNeeded(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home:
                  snapshot.data == true ? const HomePage() : const AuthenPage(),
            );
          },
        );
      }
    }

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenPage(),
    );
  }
}
