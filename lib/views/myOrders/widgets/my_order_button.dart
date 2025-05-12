import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';

class MyOrderButton extends StatelessWidget {
  const MyOrderButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color, this.textColor,
  });

  final String text;

  final VoidCallback onPressed;

  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      color: color ?? Color(0xffF6F6F6),
      minWidth: 130,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: AppTextStyles.style10W500(context).copyWith(
          color: textColor ?? AppColors.black,
          fontFamily: 'Noto Kufi Arabic',
        ),
      ),
    );
  }
}
