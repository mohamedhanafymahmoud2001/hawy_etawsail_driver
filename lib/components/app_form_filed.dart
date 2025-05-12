import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/constant.dart';
import 'package:provider/provider.dart';

import '../prov/prov.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppInputTextFormField extends StatelessWidget {
  const AppInputTextFormField(
      {super.key,
      required this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.obscureText,
      this.validator,
      this.keyboardType,
      this.controller});

  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String?)? onChanged;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Directionality(
      textDirection: val.direction,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          filled: true,
          fillColor: AppColors.white,
          labelText: labelText,
          labelStyle: AppTextStyles.style12W700(context).copyWith(
              color: AppColors.border, fontFamily: "Noto Kufi Arabic"),
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.border,
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.border,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          disabledBorder: buildOutlineInputBorder(),
          errorBorder: buildOutlineInputBorder(),
          border: buildOutlineInputBorder(),
        ),
      ),
    );});
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: BorderSide(
      width: 1,
      color: AppColors.border,
    ),
  );
}

class AppPassInputTextFormField extends StatefulWidget {
  const AppPassInputTextFormField(
      {super.key,
      this.validator,
      required this.labelText,
      this.onChanged,
      this.controller});

  final String? Function(String?)? validator;
  final String labelText;

  final void Function(String?)? onChanged;
  final TextEditingController? controller;

  @override
  State<AppPassInputTextFormField> createState() =>
      _AppPassInputTextFormFieldState();
}

class _AppPassInputTextFormFieldState extends State<AppPassInputTextFormField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return AppInputTextFormField(
      controller: widget.controller,
      labelText: widget.labelText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: isHidden,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            isHidden = !isHidden;
          });
        },
        icon: isHidden
            ? const Icon(Icons.visibility_off_outlined)
            : const Icon(Icons.visibility_outlined),
      ),
    );
  }
}
