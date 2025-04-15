import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/home_page.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/custom_text_field.dart';
// ignore_for_file: unused_local_variable

class AuthenPage extends StatefulWidget {
  const AuthenPage({super.key});

  @override
  State<AuthenPage> createState() => _AuthenPageState();
}

class _AuthenPageState extends State<AuthenPage> {
  late Widget _widget;
  late String _header;
  final TextEditingController _apiKeyController = TextEditingController();

  Future<void> _login() async {
    try {
      if (_apiKeyController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng nhập API key')),
        );
        return;
      }

      // Lưu API key và chuyển đến trang chủ
      await AuthService().saveApiKey(_apiKeyController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Có lỗi xảy ra. Vui lòng thử lại sau.')),
      );
    }
  }

  Widget _buildWelcomeWidget() {
    _header = 'Welcome';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          text: 'Sign In',
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFF1042BF),
          onPressed: () => setState(() {
            _widget = _buildSignInWidget();
          }),
        ),
      ],
    );
  }

  Widget _buildSignInWidget() {
    _header = 'Sign In';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 60),
          child: TextFormField(
            controller: _apiKeyController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Bai Jamjuree',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: 'APIKEY',
              hintStyle: TextStyle(
                color: Color(0xFF1042BF).withAlpha(51),
                fontSize: 20,
                fontFamily: 'Bai Jamjuree',
                fontWeight: FontWeight.w400,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF1042BF),
                  width: 2,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF1042BF),
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF1042BF),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        CustomButton(
          text: 'Connect',
          backgroundColor: Color(0xFF1042BF),
          foregroundColor: Colors.white,
          onPressed: _login,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _apiKeyController.text = '';
    _widget = _buildWelcomeWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/background.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: Text(
                        _header,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'Bai Jamjuree',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -40,
                      left: -10,
                      right: -10,
                      child: Image.asset(
                        'assets/vector.png',
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: _widget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
