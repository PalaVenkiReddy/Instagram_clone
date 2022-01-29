import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  // to take arguments of controller , obscure text or not, hinttext, inputtype
  final TextEditingController textEditingController;
  final bool isObscure;
  final String hintText;
  final TextInputType textInputType;
  const TextInput(
      {Key? key,
      required this.hintText,
      required this.isObscure,
      required this.textEditingController,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        border:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
        focusedBorder:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
        enabledBorder:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
      ),
      keyboardType: textInputType,
      obscureText: isObscure,
    );
  }
}
