import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/routes/app_routes.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/core/utils/booking_utils.dart';
import 'package:movie_booking_ticket/core/widgets/bottom_nav_button.dart';
import 'package:movie_booking_ticket/core/widgets/main_app_bar.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/screens/seat_selection/bloc/seat_selection_bloc.dart';
import 'package:movie_booking_ticket/screens/seat_selection/views/widgets/date_time_picker.dart';
import 'package:movie_booking_ticket/screens/seat_selection/views/widgets/seat_guide.dart';
import 'package:movie_booking_ticket/screens/seat_selection/views/widgets/seat_map_section.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key, required this.booking});

  final BookingData booking;

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final _isInteracting = ValueNotifier(false);
  final _scrollController = ScrollController();
  final _dateTimePickerKey = GlobalKey();

  @override
  void dispose() {
    _isInteracting.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onBuyTicket() {
    final state = context.read<SeatSelectionBloc>().state;
    if (!state.isDateTimeSelected) {
      final ctx = _dateTimePickerKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          alignment: 0.2,
        );
      }
      return;
    }

    final booking = widget.booking.copyWith(
      seats: state.selectedSeats,
      totalPrice: state.totalPrice,
      date: state.selectedDate,
      time: state.selectedTime,
      orderId: generateOrderId(),
    );

    context.push(AppRoutes.payment, extra: booking);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Select Seat"),
      body: ValueListenableBuilder<bool>(
        valueListenable: _isInteracting,
        builder: (context, interacting, _) {
          return SingleChildScrollView(
            controller: _scrollController,
            physics: interacting
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            child: Column(
              children: [
                Gap.h32,
                Assets.images.general.cinemaScreen.svg(
                  fit: BoxFit.cover,
                  height: 84,
                ),
                Gap.h16,
                SeatMapSection(isInteracting: _isInteracting),
                Gap.h24,
                const SeatGuide(),
                Gap.h40,
                DateTimePicker(key: _dateTimePickerKey),
                Gap.h40,
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<SeatSelectionBloc, SeatSelectionState>(
        buildWhen: (prev, curr) =>
            prev.selectedSeats.length != curr.selectedSeats.length ||
            prev.isDateTimeSelected != curr.isDateTimeSelected,
        builder: (context, state) {
          return MainBottomNavButton(
            customWidget: SizedBox(
              height: 56,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total", style: context.textTheme.bodyLarge),
                        Text(
                          "${state.totalPrice.toStringAsFixed(2)} THB",
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state.selectedSeats.isEmpty
                            ? null
                            : () => _onBuyTicket(),
                        child: Text(
                          "Buy Ticket",
                          style: context.textTheme.titleLarge?.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
