import 'dart:math';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:get/get.dart';
import 'package:project/constants/app_data.dart';

class AppUtils {
  AppUtils._();

  static void saveApiKey(String apiKey) {
    final sharedRef = Get.find<EncryptedSharedPreferences>();
    sharedRef.setString(AppData.apiKey, apiKey);
  }

  static bool isAuthenticated() {
    final sharedRef = Get.find<EncryptedSharedPreferences>();
    return sharedRef.getBool(AppData.apiKey) ?? false;
  }

  static String generateKey() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random.secure();
    return List.generate(16, (index) => chars[rand.nextInt(chars.length)])
        .join();
  }
}
