import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/di.dart';
import 'package:project/modules/authentication/wellcome_view.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/pages/authen_page.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/app_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjections().dependencies();
  // await AuthService().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final apiKey = authService.getApiKey();
    final isAuthenticated = AppUtils.isAuthenticated();
    print(">>>>>>isAuthenticated: $isAuthenticated");

    return GetMaterialApp(
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 300),
      debugShowCheckedModeBanner: false,
      home: isAuthenticated ? HomePage() : WellcomeView(),
    );
  }
}
