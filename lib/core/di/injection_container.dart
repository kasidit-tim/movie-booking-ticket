import 'package:get_it/get_it.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';
import 'package:movie_booking_ticket/screens/main/home/data/home_repository.dart';
import 'package:movie_booking_ticket/screens/main/movie/data/movie_repository.dart';
import 'package:movie_booking_ticket/screens/main/ticket/data/booking_repository.dart';
import 'package:movie_booking_ticket/screens/movie_detail/data/movie_detail_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies(DioClient dio) async {
  // Core
  getIt.registerSingleton<DioClient>(dio);

  // Local storage
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository(getIt()));
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepository(getIt()));
  getIt.registerLazySingleton<MovieDetailRepository>(
    () => MovieDetailRepository(getIt()),
  );
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepository(getIt()),
  );
}