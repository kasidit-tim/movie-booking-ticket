import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/screens/seat_selection/bloc/seat_selection_bloc.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key});

  static const _timeSlots = [
    "10:30",
    "12:45",
    "14:15",
    "16:30",
    "18:45",
    "20:30",
    "22:15",
  ];

  static const _months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      SeatSelectionBloc,
      SeatSelectionState,
      ({DateTime? date, String? time})
    >(
      selector: (state) => (date: state.selectedDate, time: state.selectedTime),
      builder: (context, selection) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Select Date & Time", style: context.textTheme.titleLarge),
            Gap.h24,
            _buildDateList(context, selection.date),
            Gap.h24,
            _buildTimeList(context, selection.time),
          ],
        );
      },
    );
  }

  Widget _buildDateList(BuildContext context, DateTime? selectedDate) {
    final today = DateTime.now();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (i) {
          final date = today.add(Duration(days: i));
          final isSelected =
              selectedDate != null &&
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;

          final alphaValue = isSelected ? 1.0 : 0.8;

          return GestureDetector(
            onTap: () {
              final bloc = context.read<SeatSelectionBloc>();
              bloc.add(SelectDateEvent(date));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 4,
                left: 8,
                right: 8,
              ),
              decoration: BoxDecoration(
                color: (isSelected ? AppColors.primary : AppColors.darkGrey)
                    .withValues(alpha: alphaValue),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                children: [
                  Text(
                    _months[date.month - 1],
                    style: context.textTheme.titleMedium?.copyWith(
                      color: (isSelected ? AppColors.black : AppColors.white)
                          .withValues(alpha: alphaValue),
                    ),
                  ),
                  Gap.h16,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (isSelected
                                  ? AppColors.darkGrey
                                  : const Color(0xFF3B3B3B))
                              .withValues(alpha: alphaValue),
                    ),
                    child: Text(
                      "${date.day}",
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.textTheme.titleMedium?.color?.withValues(
                          alpha: alphaValue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTimeList(BuildContext context, String? selectedTime) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_timeSlots.length, (i) {
          final time = _timeSlots[i];
          final isSelected = time == selectedTime;
          final alphaValue = isSelected ? 1.0 : 0.8;

          return GestureDetector(
            onTap: () {
              final bloc = context.read<SeatSelectionBloc>();
              bloc.add(SelectTimeEvent(time));
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 1)
                    : null,
                color:
                    (isSelected ? AppColors.cardSelected : AppColors.darkGrey)
                        .withValues(alpha: alphaValue),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Text(
                time,
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.white.withValues(alpha: alphaValue),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
