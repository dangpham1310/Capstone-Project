import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'token';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _tokenExpiryKey = 'tokenExpiry';
  static const String _baseUrl = 'https://thingsboard.cloud/api';
  static final AuthService _instance = AuthService._internal();
  static SharedPreferences? _prefs;

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveTokens(String token, String refreshToken) async {
    final tokenData = parseJwt(token);
    final expiryTime =
        DateTime.fromMillisecondsSinceEpoch(tokenData['exp'] * 1000);

    await _prefs?.setString(_tokenKey, token);
    await _prefs?.setString(_refreshTokenKey, refreshToken);
    await _prefs?.setString(_tokenExpiryKey, expiryTime.toIso8601String());
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);

    return payloadMap;
  }

  bool isTokenValid() {
    final expiryTimeStr = _prefs?.getString(_tokenExpiryKey);
    if (expiryTimeStr == null) return false;

    final expiryTime = DateTime.parse(expiryTimeStr);
    return DateTime.now().isBefore(expiryTime);
  }

  Future<bool> refreshTokenIfNeeded() async {
    if (isTokenValid()) return true;

    final refreshToken = getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        await saveTokens(responseData['token'], responseData['refreshToken']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  String? getToken() {
    return _prefs?.getString(_tokenKey);
  }

  String? getRefreshToken() {
    return _prefs?.getString(_refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _prefs?.remove(_tokenKey);
    await _prefs?.remove(_refreshTokenKey);
  }
}
