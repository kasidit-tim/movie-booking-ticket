import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_booking_ticket/core/di/injection_container.dart';
import 'package:movie_booking_ticket/core/network/api_config.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';
import 'package:movie_booking_ticket/core/routes/app_router.dart';
import 'package:movie_booking_ticket/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final dioClient = DioClient();
  await ApiConfig.configure(dioClient);
  await configureDependencies(dioClient);
  runApp(const MovieBookingTicket());
}

class MovieBookingTicket extends StatelessWidget {
  const MovieBookingTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      title: 'Movie Booking Ticket',
      theme: AppTheme.dark,
    );
  }
}
