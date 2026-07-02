import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';

class MovieTabButton extends StatelessWidget {
  const MovieTabButton({
    super.key,
    required this.title,
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final MovieTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                color: isSelected ? AppColors.black : AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
