import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    super.key,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: AppColors.textFieldBg,
        focusColor: AppColors.textFieldBg,
        hoverColor: AppColors.textFieldBg,
        prefixIcon:
            prefixIcon ??
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: Assets.images.general.search.svg(),
            ),
        prefixIconConstraints: BoxConstraints(minHeight: 24, maxHeight: 24),
        hintText: hintText ?? "Search",
        hintStyle:
            hintStyle ??
            context.textTheme.bodyLarge?.copyWith(color: AppColors.hintText),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
