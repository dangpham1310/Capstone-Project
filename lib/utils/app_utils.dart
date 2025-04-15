import 'package:encrypt_shared_preferences/provider.dart';
import 'package:get/get.dart';
import 'package:project/constants/app_data.dart';

class AppUtils {
  AppUtils._();

  static Future<void> saveApiKey(String apiKey) async {
    final sharedRef = Get.find<EncryptedSharedPreferences>();
    sharedRef.setString(AppData.apiKey, apiKey);
  }
}
