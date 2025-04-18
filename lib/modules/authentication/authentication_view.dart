import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import 'authentication_logic.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key}) : super(key: key);
  TextEditingController textEditController = TextEditingController();
  final AuthenticationLogic logic = Get.put(AuthenticationLogic());
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
                        "Sign In",
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
                child: _buildSignInWidget(logic),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }

  Widget _buildSignInWidget(AuthenticationLogic logic) {
    return Form(
      key: logic.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60),
            child: TextFormField(
              controller: textEditController,
              validator: (e) {
                String value = e ?? "";
                if (value.isEmpty) {
                  return "Vui lòng nhập API KEY";
                }
                if (value.length < 10) {
                  return "Độ dài của API KEY phải từ 10 kí tự trở lên";
                }
                return null;
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Bai Jamjuree',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Nhập API KEY',
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
            onPressed: () => logic.connect(textEditController.text),
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
