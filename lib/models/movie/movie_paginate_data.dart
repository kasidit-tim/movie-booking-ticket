import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

part 'movie_paginate_data.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MoviePaginateData {
  int? page;
  List<MovieDataModel>? results;
  int? totalPages;
  int? totalResults;

  MoviePaginateData({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MoviePaginateData.empty() {
    return MoviePaginateData(
      page: 0,
      results: const [],
      totalPages: 0,
      totalResults: 0,
    );
  }

  factory MoviePaginateData.fromJson(Map<String, dynamic> json) =>
      _$MoviePaginateDataFromJson(json);

  Map<String, dynamic> toJson() => _$MoviePaginateDataToJson(this);
}
