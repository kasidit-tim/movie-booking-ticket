import 'package:movie_booking_ticket/models/movie/certification_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

final kSkeletonMovie = MovieDataModel(
  id: 0,
  title: 'Placeholder Movie Title',
  overview:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  runtime: 120,
  voteAverage: 8.5,
  voteCount: 1234,
  genres: [
    Genre(id: 0, name: 'Action'),
    Genre(id: 1, name: 'Adventure'),
  ],
  originalLanguage: 'en',
  posterPath: '',
  certifications: CertificationData(
    results: [
      CountryReleaseDates(
        iso31661: "TH",
        releaseDates: [ReleaseDateEntry(certification: "18")],
      ),
    ],
  ),
);
