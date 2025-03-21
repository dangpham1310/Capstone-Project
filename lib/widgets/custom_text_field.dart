import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String assetPath;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.assetPath,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Bai Jamjuree',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFF1042BF).withAlpha(51),
            fontSize: 20,
            fontFamily: 'Bai Jamjuree',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 15),
            child: Image.asset(assetPath),
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
    );
  }
}
