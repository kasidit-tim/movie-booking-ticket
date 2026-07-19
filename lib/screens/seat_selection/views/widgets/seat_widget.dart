import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/screens/seat_selection/bloc/seat_selection_bloc.dart';
import 'package:movie_booking_ticket/screens/seat_selection/views/widgets/seat_map_section.dart';

enum SeatStatus { available, selected, reserved }

class SeatWidget extends StatelessWidget {
  final String seatNo;
  final SeatStatus? status;

  const SeatWidget({super.key, required this.seatNo, this.status});

  @override
  Widget build(BuildContext context) {
    final effectiveStatus =
        status ??
        context.select<SeatSelectionBloc, SeatStatus>((bloc) {
          final state = bloc.state;
          if (state.reservedSeats.contains(seatNo)) return SeatStatus.reserved;
          if (state.selectedSeats.contains(seatNo)) return SeatStatus.selected;
          return SeatStatus.available;
        });

    debugPrint("SeatWidget build: $seatNo → $effectiveStatus");
    return GestureDetector(
      onTap: effectiveStatus == SeatStatus.reserved || seatNo.isEmpty
          ? null
          : () {
              final bloc = context.read<SeatSelectionBloc>();
              bloc.add(ToggleSeatEvent(seatNo));
            },
      child: Container(
        width: SeatConfig.size,
        height: SeatConfig.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: switch (effectiveStatus) {
            SeatStatus.available => AppColors.card,
            SeatStatus.selected => AppColors.primary,
            SeatStatus.reserved => AppColors.cardSelected,
          },
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          seatNo,
          style: context.textTheme.bodySmall?.copyWith(
            color: switch (effectiveStatus) {
              SeatStatus.available => AppColors.white,
              SeatStatus.selected => AppColors.black,
              SeatStatus.reserved => AppColors.primary,
            },
          ),
        ),
      ),
    );
  }
}
