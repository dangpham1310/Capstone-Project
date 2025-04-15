import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as GET;
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:project/constants/app_data.dart';
import 'package:project/data/services/capstone_service.dart';

class DependencyInjections implements GET.Bindings {
  @override
  Future<void> dependencies() async {
    final sharedRef = await GET.Get.putAsync(_encryptedSharedPreferences);
    final dio = await GET.Get.putAsync(() => _dio(sharedRef));
    GET.Get.put(CapstoneService(dio));
  }

  Future<Dio> _dio(EncryptedSharedPreferences sharedPref) async {
    var dio = Dio();

    if (kDebugMode) {
      dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    }
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String apiKey = sharedPref.getString(AppData.apiKey) ?? "";
      options.headers = {
        "Access-Control-Allow-Origin": "*",
        "api_key": apiKey,
        ...options.headers
      };
    }, onError: (error, handler) {
      handler.next(error);
    }, onResponse: (res, handler) {
      handler.next(res);
    }));
    return dio;
  }

  Future<EncryptedSharedPreferences> _encryptedSharedPreferences() async {
    var sharedPref = EncryptedSharedPreferences.getInstance();
    return sharedPref;
  }
}
