import 'package:json_annotation/json_annotation.dart';

part 'movie_video.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieVideo {
  final String id;
  @JsonKey(name: "iso_639_1")
  final String iso6391;
  @JsonKey(name: "iso_3166_1")
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;

  const MovieVideo({
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  factory MovieVideo.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVideoToJson(this);

  String? get youtubeUrl {
    if (site != 'YouTube') return null;
    return 'https://www.youtube.com/watch?v=$key';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieVideoResponse {
  final int id;
  final List<MovieVideo> results;

  const MovieVideoResponse({required this.id, this.results = const []});

  factory MovieVideoResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVideoResponseToJson(this);

  MovieVideo? get officialTrailer {
    for (final v in results) {
      if (v.type == 'Trailer' && v.official && v.site == 'YouTube') return v;
    }
    return null;
  }

  MovieVideo? get anyYoutubeVideo {
    for (final v in results) {
      if (v.site == 'YouTube') return v;
    }
    return null;
  }
}
