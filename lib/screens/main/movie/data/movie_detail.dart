import 'package:equatable/equatable.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

class MovieDetail extends Equatable {
  final int? runtime;
  final List<Genre>? genres;

  const MovieDetail({this.runtime, this.genres});

  String get runTime {
    if (runtime == null) return '';
    final hours = runtime! ~/ 60;
    final minutes = runtime! % 60;
    if (hours == 0) return '$minutes minute${minutes == 1 ? '' : 's'}';
    if (minutes == 0) return '$hours hour${hours == 1 ? '' : 's'}';
    return '$hours hour${hours == 1 ? '' : 's'} $minutes minute${minutes == 1 ? '' : 's'}';
  }

  String get genresText => genres?.map((g) => g.name).join(', ') ?? '';

  @override
  List<Object?> get props => [runtime, genres];
}