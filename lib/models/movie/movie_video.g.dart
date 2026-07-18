// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVideo _$MovieVideoFromJson(Map<String, dynamic> json) => MovieVideo(
  id: json['id'] as String,
  iso6391: json['iso_639_1'] as String,
  iso31661: json['iso_3166_1'] as String,
  name: json['name'] as String,
  key: json['key'] as String,
  site: json['site'] as String,
  size: (json['size'] as num).toInt(),
  type: json['type'] as String,
  official: json['official'] as bool,
  publishedAt: DateTime.parse(json['published_at'] as String),
);

Map<String, dynamic> _$MovieVideoToJson(MovieVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iso_639_1': instance.iso6391,
      'iso_3166_1': instance.iso31661,
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'published_at': instance.publishedAt.toIso8601String(),
    };

MovieVideoResponse _$MovieVideoResponseFromJson(Map<String, dynamic> json) =>
    MovieVideoResponse(
      id: (json['id'] as num).toInt(),
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => MovieVideo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MovieVideoResponseToJson(MovieVideoResponse instance) =>
    <String, dynamic>{'id': instance.id, 'results': instance.results};
