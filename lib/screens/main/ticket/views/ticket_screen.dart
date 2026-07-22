import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/routes/app_routes.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/core/widgets/main_app_bar.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/screens/main/ticket/bloc/ticket_bloc.dart';
import 'package:movie_booking_ticket/screens/main/ticket/views/widgets/ticket_list_item.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/data/ticket_detail_args.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "My ticket", showBackBtn: false),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state.bookings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.navBar.ticket.svg(
                    height: 64,
                    width: 64,
                    colorFilter: const ColorFilter.mode(
                      AppColors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  Gap.h16,
                  Text(
                    "No tickets yet",
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  Gap.h8,
                  Text(
                    "Book a movie to see your tickets here",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 32, left: 16, right: 12),
            itemCount: state.bookings.length,
            itemBuilder: (context, i) {
              final booking = state.bookings[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TicketListItem(
                  booking: booking,
                  onTap: () {
                    context.push(
                      AppRoutes.ticketDetail,
                      extra: TicketDetailArgs(bookingData: booking),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
