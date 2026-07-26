import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_ticket/core/constants/app_constants.dart';
import 'package:movie_booking_ticket/models/movie/certification_data.dart';

part 'movie_data.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDataModel extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final bool? softcore;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  @JsonKey(name: 'release_dates')
  final CertificationData? certifications;

  const MovieDataModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.softcore,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.certifications,
  });

  factory MovieDataModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDataModelToJson(this);

  static List<MovieDataModel> parseList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => MovieDataModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  bool get hasDetail => runtime != null && genres != null;

  String get shortRunTime =>
      runtime != null ? '${runtime! ~/ 60}h${runtime! % 60}m' : '';

  String get runTime {
    if (runtime == null) return '';

    final hours = runtime! ~/ 60;
    final minutes = runtime! % 60;

    if (hours == 0) {
      return '$minutes minute${minutes == 1 ? '' : 's'}';
    }

    if (minutes == 0) {
      return '$hours hour${hours == 1 ? '' : 's'}';
    }

    return '$hours hour${hours == 1 ? '' : 's'} '
        '$minutes minute${minutes == 1 ? '' : 's'}';
  }

  String get getGenres => genres?.map((g) => g.name).join(', ') ?? '';

  String get getPosterImgW500 => ((posterPath ?? "").isNotEmpty)
      ? "${AppConstants.imageW500}$posterPath"
      : "";

  String get getBackdropOriginal => ((backdropPath ?? "").isNotEmpty)
      ? "${AppConstants.imageOriginal}$backdropPath"
      : "";

  String get getReleaseDate {
    if (releaseDate == null) return '';
    return '${releaseDate!.day.toString().padLeft(2, '0')}.${releaseDate!.month.toString().padLeft(2, '0')}.${releaseDate!.year}';
  }

  String get thaiCertification {
    final cert = certifications?.forCountry('TH') ?? '';
    if (cert.isEmpty) return '';
    return RegExp(r'^\d+$').hasMatch(cert) ? '$cert+' : cert;
  }

  @override
  List<Object?> get props => [id, runtime, genres, certifications];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompany {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompany({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountry {
  String? iso31661;
  String? name;

  ProductionCountry({this.iso31661, this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}
