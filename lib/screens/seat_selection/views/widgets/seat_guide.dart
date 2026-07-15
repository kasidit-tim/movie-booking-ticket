import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/screens/seat_selection/views/widgets/seat_widget.dart';

class SeatGuide extends StatelessWidget {
  const SeatGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8,
            children: [
              SeatWidget(seatNo: "", status: SeatStatus.available),
              Text("Available"),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              SeatWidget(seatNo: "", status: SeatStatus.reserved),
              Text("Reserved"),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              SeatWidget(seatNo: "", status: SeatStatus.selected),
              Text("Selected"),
            ],
          ),
        ],
      ),
    );
  }
}
