import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/screens/main/home/bloc/home_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/views/home_screen.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';
import 'package:movie_booking_ticket/screens/main/views/main_screen.dart';
import 'package:movie_booking_ticket/screens/main/movie/views/movie_screen.dart';
import 'package:movie_booking_ticket/screens/main/profile/views/profile_screen.dart';
import 'package:movie_booking_ticket/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/movie_detail_screen.dart';
import 'package:movie_booking_ticket/screens/payment/views/payment_views.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/screens/seat_selection/bloc/seat_selection_bloc.dart';
import 'package:movie_booking_ticket/screens/seat_selection/views/seat_selection_screen.dart';
import 'package:movie_booking_ticket/screens/splash/bloc/splash_bloc.dart';
import 'package:movie_booking_ticket/screens/splash/views/splash_screen.dart';
import 'package:movie_booking_ticket/screens/main/ticket/views/ticket_screen.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/views/ticket_detail_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (ctx, state) {
          return BlocProvider(
            create: (_) => SplashBloc()..add(StartAppInitEvent()),
            child: SplashScreen(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          /// Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.homeTab,
                builder: (context, state) => BlocProvider(
                  create: (_) => HomeBloc()
                    ..add(LoadNowPlayingMovie())
                    ..add(LoadComingSoonMovie()),
                  child: HomeScreen(),
                ),
              ),
            ],
          ),

          /// Ticket
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ticketTab,
                builder: (context, state) => const TicketScreen(),
              ),
            ],
          ),

          /// Movie
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.movieTab,
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      MovieBloc()
                        ..add(LoadMoviesEvent(tab: MovieTab.nowPlaying)),
                  child: MovieScreen(),
                ),
              ),
            ],
          ),

          /// Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profileTab,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '${AppRoutes.movieDetail}/:id',
        builder: (ctx, state) {
          final id = int.parse(state.pathParameters['id']!);
          return BlocProvider(
            create: (_) => MovieDetailBloc()..add(LoadMovieDetailEvent(id: id)),
            child: MovieDetailScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.selectSeat,
        builder: (ctx, state) {
          final booking = state.extra as BookingData;
          return BlocProvider(
            create: (_) => SeatSelectionBloc(),
            child: SeatSelectionScreen(booking: booking),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.payment,
        builder: (ctx, state) {
          final booking = state.extra as BookingData;
          return PaymentScreen(booking: booking);
        },
      ),
      GoRoute(
        path: AppRoutes.ticketDetail,
        builder: (ctx, state) {
          final booking = state.extra as BookingData;
          return TicketDetailScreen(booking: booking);
        },
      ),
    ],
  );
}
