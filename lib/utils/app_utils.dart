import 'dart:math';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:get/get.dart';
import 'package:project/constants/app_data.dart';

class AppUtils {
  AppUtils._();

  static Future<void> saveApiKey(String apiKey) async {
    final sharedRef = Get.find<EncryptedSharedPreferences>();
    await sharedRef.setString(AppData.apiKey, apiKey);
  }

  static bool isAuthenticated() {
    final sharedRef = Get.find<EncryptedSharedPreferences>();
    return sharedRef.getString(AppData.apiKey) != null;
  }
}
