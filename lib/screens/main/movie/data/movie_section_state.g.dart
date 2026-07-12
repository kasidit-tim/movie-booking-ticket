// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_section_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MovieSectionStateCWProxy {
  MovieSectionState movies(MoviePaginateData movies);

  MovieSectionState isLoading(bool isLoading);

  MovieSectionState isLoadingMore(bool isLoadingMore);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MovieSectionState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MovieSectionState(...).copyWith(id: 12, name: "My name")
  /// ```
  MovieSectionState call({
    MoviePaginateData movies,
    bool isLoading,
    bool isLoadingMore,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMovieSectionState.copyWith(...)` or call `instanceOfMovieSectionState.copyWith.fieldName(value)` for a single field.
class _$MovieSectionStateCWProxyImpl implements _$MovieSectionStateCWProxy {
  const _$MovieSectionStateCWProxyImpl(this._value);

  final MovieSectionState _value;

  @override
  MovieSectionState movies(MoviePaginateData movies) => call(movies: movies);

  @override
  MovieSectionState isLoading(bool isLoading) => call(isLoading: isLoading);

  @override
  MovieSectionState isLoadingMore(bool isLoadingMore) =>
      call(isLoadingMore: isLoadingMore);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MovieSectionState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MovieSectionState(...).copyWith(id: 12, name: "My name")
  /// ```
  MovieSectionState call({
    Object? movies = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isLoadingMore = const $CopyWithPlaceholder(),
  }) {
    return MovieSectionState(
      movies: movies == const $CopyWithPlaceholder() || movies == null
          ? _value.movies
          // ignore: cast_nullable_to_non_nullable
          : movies as MoviePaginateData,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isLoadingMore:
          isLoadingMore == const $CopyWithPlaceholder() || isLoadingMore == null
          ? _value.isLoadingMore
          // ignore: cast_nullable_to_non_nullable
          : isLoadingMore as bool,
    );
  }
}

extension $MovieSectionStateCopyWith on MovieSectionState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMovieSectionState.copyWith(...)` or `instanceOfMovieSectionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MovieSectionStateCWProxy get copyWith =>
      _$MovieSectionStateCWProxyImpl(this);
}
