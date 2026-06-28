import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/routes/app_routes.dart';
import 'package:movie_booking_ticket/screens/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigationReady) {
          context.go(AppRoutes.home);
        }
      },

      child: Scaffold(body: Center(child: Text("Splash"))),
    );
  }
}
