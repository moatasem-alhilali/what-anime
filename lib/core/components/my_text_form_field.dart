import 'package:anime_finder/core/resources/assets_fonts.dart';
import 'package:flutter/material.dart';
import 'package:anime_finder/core/themes/dark_theme.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.suffixIcon,
    this.height,
    this.onChanged,
    this.readOnly,
    this.controller,
    this.messageValidate,
    this.validator,
    this.prefixIcon,
  });
  String? hintText;
  String? Function(String?)? validator;
  String? labelText;
  String? messageValidate;
  double? height;
  TextEditingController? controller;
  TextAlign? textAlign;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? readOnly;
  TextInputType? keyboardType;

  final Function(String text)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: height,
        child: TextFormField(
          style: getTitleSmallTheme(context),
          inputFormatters: const [
            // FilteringTextInputFormatter.allow(RegExp(r"^\+?0[0-9]{10}$")
            // RegExp(r"[a-zA-Z]+|\s"),
            //     ),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return messageValidate ?? "The Field Cant Be Empty";
            }
            return null;
          },
          controller: controller,
          keyboardType: keyboardType,
          textAlign: textAlign!,
          decoration: InputDecoration(
            suffixStyle: const TextStyle(
              color: Color(0xff393939),
            ),
            prefixStyle: const TextStyle(
              color: Color(0xff393939),
            ),
            suffixIconColor: Theme.of(context).primaryColorLight,
            prefixIconColor: Theme.of(context).primaryColorLight,
            labelText: labelText,
            filled: true,
            hintText: hintText,
            helperStyle: Theme.of(context).textTheme.headlineSmall,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
