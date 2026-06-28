import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/screens/home/views/home_screen.dart';
import 'package:movie_booking_ticket/screens/splash/bloc/splash_bloc.dart';
import 'package:movie_booking_ticket/screens/splash/views/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
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
      GoRoute(path: AppRoutes.home, builder: (ctx, state) => HomeScreen()),
    ],
  );
}
