import 'package:delivery_app_example/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField(
      {Key? key,
      this.onChanged,
      this.autofocus = false,
      this.obscureText = false,
      this.hintText,
      this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 1,
    ));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
          fillColor: INPUT_BG_COLOR,
          filled: true,
          border: baseBorder,
          focusedBorder: baseBorder.copyWith(
              borderSide:
                  baseBorder.borderSide.copyWith(color: PRIMARY_COLOR))),
    );
  }
}
