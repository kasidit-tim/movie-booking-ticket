import 'package:get_it/get_it.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';
import 'package:movie_booking_ticket/screens/main/home/data/home_repository.dart';
import 'package:movie_booking_ticket/screens/main/movie/data/movie_repository.dart';
import 'package:movie_booking_ticket/screens/movie_detail/data/movie_detail_repository.dart';

final getIt = GetIt.instance;

void configureDependencies(DioClient dio) {
  // Core
  getIt.registerSingleton<DioClient>(dio);

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository(getIt()));
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepository(getIt()));
  getIt.registerLazySingleton<MovieDetailRepository>(
    () => MovieDetailRepository(getIt()),
  );
}
