import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/di/injection_container.dart';
import 'package:movie_booking_ticket/screens/main/bloc/main_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/bloc/home_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/data/home_repository.dart';
import 'package:movie_booking_ticket/screens/main/movie/data/movie_repository.dart';
import 'package:movie_booking_ticket/screens/movie_detail/data/movie_detail_repository.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';
import 'package:movie_booking_ticket/screens/main/views/main_screen.dart';
import 'package:movie_booking_ticket/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/movie_detail_screen.dart';
import 'package:movie_booking_ticket/screens/payment/views/payment_views.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/models/movie_detail_args.dart';
import 'package:movie_booking_ticket/screens/seat_selection/bloc/seat_selection_bloc.dart';
import 'package:movie_booking_ticket/screens/seat_selection/views/seat_selection_screen.dart';
import 'package:movie_booking_ticket/screens/splash/bloc/splash_bloc.dart';
import 'package:movie_booking_ticket/screens/splash/views/splash_screen.dart';
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
      GoRoute(
        path: AppRoutes.main,
        builder: (ctx, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => MainBloc()),
              BlocProvider(
                create: (_) => HomeBloc(getIt<HomeRepository>())
                  ..add(LoadNowPlayingMovie())
                  ..add(LoadComingSoonMovie()),
              ),
              BlocProvider(create: (_) => MovieBloc(getIt<MovieRepository>())),
            ],
            child: MainScreen(),
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.movieDetail}/:id',
        builder: (ctx, state) {
          final id = int.parse(state.pathParameters['id']!);
          final args = state.extra as MovieDetailArgs;
          return BlocProvider(
            create: (_) =>
                MovieDetailBloc(getIt<MovieDetailRepository>())
                  ..add(LoadMovieDetailEvent(id: id)),
            child: MovieDetailScreen(isComingSoon: args.isComingSoon),
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
