// ── Mocks ──────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_booking_ticket/screens/main/bloc/main_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/bloc/home_bloc.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';
import 'package:movie_booking_ticket/screens/main/my_ticket/bloc/ticket_bloc.dart';
import 'package:movie_booking_ticket/screens/main/my_ticket/data/booking_repository.dart';
import 'package:movie_booking_ticket/screens/main/views/main_screen.dart';

import 'fakes/fake_movie_repository.dart';
import 'helpers/golden_devices.dart';
import 'helpers/pump_app.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

// ── Tests ──────────────────────────────────────────────────────────

void main() {
  late MockBookingRepository mockBookingRepo;

  setUp(() {
    mockBookingRepo = MockBookingRepository();
    when(() => mockBookingRepo.getBookings()).thenReturn([]);
  });

  Widget buildSubject() {
    final homeBloc = HomeBloc(FakeHomeRepository())
      ..add(const LoadNowPlayingMovie())
      ..add(const LoadComingSoonMovie());

    return createTestApp(
      const MainScreen(),
      blocProviders: [
        BlocProvider<MainBloc>(
          create: (_) =>
              MainBloc()..add(NavigateToTabEvent(page: PageTab.movie)),
        ),
        BlocProvider<HomeBloc>.value(value: homeBloc),
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(FakeMovieRepository()),
        ),
        BlocProvider<TicketBloc>(
          create: (_) =>
              TicketBloc(mockBookingRepo)..add(const LoadBookingsEvent()),
        ),
      ],
    );
  }

  testGoldens('MainScreen - moive tab on phone', (tester) async {
    await tester.pumpWidget(buildSubject());
    // Carousel uses infinite animations so pumpAndSettle would time out.
    // Pump a fixed duration to let bloc futures and rendering settle.
    await tester.pump(const Duration(seconds: 5));

    await multiScreenGolden(
      tester,
      'main_screen_movie',
      devices: const [GoldenDevices.phone],
    );
  });

  testGoldens('MainScreen - moive tab on iphone 17', (tester) async {
    await tester.pumpWidget(buildSubject());
    // Carousel uses infinite animations so pumpAndSettle would time out.
    // Pump a fixed duration to let bloc futures and rendering settle.
    await tester.pump(const Duration(seconds: 5));

    await multiScreenGolden(
      tester,
      'main_screen_movie',
      devices: const [GoldenDevices.iphone17],
    );
  });

  testGoldens('MainScreen - moive tab on tablet', (tester) async {
    await tester.pumpWidget(buildSubject());
    await tester.pump(const Duration(seconds: 5));

    await multiScreenGolden(
      tester,
      'main_screen_movie_tablet',
      devices: const [GoldenDevices.tablet],
    );
  });
}
