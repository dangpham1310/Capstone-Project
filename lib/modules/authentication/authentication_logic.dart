import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/constants/app_data.dart';
import 'package:project/data/capstone_datasource.dart';
import 'package:project/pages/home_page.dart';

class AuthenticationLogic extends GetxController {
  final dataSource = Get.find<CapstoneDataSources>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> connect(String apiKey) async {
    print(">>>>>>>apiKey: $apiKey");
    print(">>>>>>>default: ${AppData.apiKeyDefault}");
    if (formKey.currentState?.validate() == true) {
      if (apiKey.trim().toLowerCase() !=
          AppData.apiKeyDefault.trim().toLowerCase()) {
        Get.snackbar(
          "Có lỗi xảy ra",
          "API KEY ĐÃ NHẬP KHÔNG CHÍNH XÁC",
        );
        return;
      }
      await dataSource.saveApiKey(apiKey);
      Get.to(HomePage());
    }
  }
}
