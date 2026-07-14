import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/widgets/main_app_bar.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/models/ticket_detail_data.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/views/widgets/ticket_card.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'My ticket'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap.h40,
            TicketCard(
              ticket: TicketDetailData(
                movieTitle: 'Avengers: Infinity War',
                posterUrl:
                    'https://media.themoviedb.org/t/p/w220_and_h330_face/aB5X0TvSbuLew3HheiueMFYsdnx.jpg',
                duration: '2 hours 29 minutes',
                genres: 'Action, adventure, sci-fi',
                showTime: "14h15'",
                showDate: '14.07.2026',
                section: 4,
                seats: ["H7", "H8"],
                price: 210,
                cinemaName: 'Major Cineplex Central Bangna',
                cinemaAddress:
                    '5th floor, 12 Soi Bangna-Trad 42, Bang Na Nuea, Khet Bang Na, Bangkok 10260.',
                orderId: '78889377726',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
