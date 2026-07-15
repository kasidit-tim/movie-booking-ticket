import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';

class MainBottomNavButton extends StatelessWidget {
  const MainBottomNavButton({
    super.key,
    this.label = "",
    this.onPressed,
    this.customWidget,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? customWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 0, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child:
                customWidget ??
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(
                      label,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
