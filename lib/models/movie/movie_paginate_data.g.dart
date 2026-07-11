// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_paginate_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MoviePaginateDataCWProxy {
  MoviePaginateData page(int? page);

  MoviePaginateData results(List<MovieDataModel>? results);

  MoviePaginateData totalPages(int? totalPages);

  MoviePaginateData totalResults(int? totalResults);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MoviePaginateData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MoviePaginateData(...).copyWith(id: 12, name: "My name")
  /// ```
  MoviePaginateData call({
    int? page,
    List<MovieDataModel>? results,
    int? totalPages,
    int? totalResults,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMoviePaginateData.copyWith(...)` or call `instanceOfMoviePaginateData.copyWith.fieldName(value)` for a single field.
class _$MoviePaginateDataCWProxyImpl implements _$MoviePaginateDataCWProxy {
  const _$MoviePaginateDataCWProxyImpl(this._value);

  final MoviePaginateData _value;

  @override
  MoviePaginateData page(int? page) => call(page: page);

  @override
  MoviePaginateData results(List<MovieDataModel>? results) =>
      call(results: results);

  @override
  MoviePaginateData totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  MoviePaginateData totalResults(int? totalResults) =>
      call(totalResults: totalResults);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MoviePaginateData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MoviePaginateData(...).copyWith(id: 12, name: "My name")
  /// ```
  MoviePaginateData call({
    Object? page = const $CopyWithPlaceholder(),
    Object? results = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
    Object? totalResults = const $CopyWithPlaceholder(),
  }) {
    return MoviePaginateData(
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int?,
      results: results == const $CopyWithPlaceholder()
          ? _value.results
          // ignore: cast_nullable_to_non_nullable
          : results as List<MovieDataModel>?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
      totalResults: totalResults == const $CopyWithPlaceholder()
          ? _value.totalResults
          // ignore: cast_nullable_to_non_nullable
          : totalResults as int?,
    );
  }
}

extension $MoviePaginateDataCopyWith on MoviePaginateData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMoviePaginateData.copyWith(...)` or `instanceOfMoviePaginateData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MoviePaginateDataCWProxy get copyWith =>
      _$MoviePaginateDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviePaginateData _$MoviePaginateDataFromJson(Map<String, dynamic> json) =>
    MoviePaginateData(
      page: (json['page'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      totalResults: (json['total_results'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MoviePaginateDataToJson(MoviePaginateData instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
