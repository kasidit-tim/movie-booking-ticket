import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_ticket/core/constants/app_constants.dart';

part 'movie_credits.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieCredits extends Equatable {
  final int id;
  final List<CastMember> cast;
  final List<CrewMember> crew;

  const MovieCredits({
    required this.id,
    this.cast = const [],
    this.crew = const [],
  });

  factory MovieCredits.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsToJson(this);

  List<CrewMember> get directors =>
      crew.where((c) => c.job == 'Director').toList();

  @override
  List<Object?> get props => [cast, crew];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CastMember {
  final int id;
  final String name;
  final String? profilePath;
  final String? character;

  const CastMember({
    required this.id,
    required this.name,
    this.profilePath,
    this.character,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) =>
      _$CastMemberFromJson(json);

  Map<String, dynamic> toJson() => _$CastMemberToJson(this);

  String get profileImageUrl {
    if (profilePath == null) return '';
    return '${AppConstants.imageW185}$profilePath';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CrewMember {
  final int id;
  final String name;
  final String? profilePath;
  final String? job;

  const CrewMember({
    required this.id,
    required this.name,
    this.profilePath,
    this.job,
  });

  factory CrewMember.fromJson(Map<String, dynamic> json) =>
      _$CrewMemberFromJson(json);

  Map<String, dynamic> toJson() => _$CrewMemberToJson(this);

  String get profileImageUrl {
    if (profilePath == null) return '';
    return '${AppConstants.imageW185}$profilePath';
  }
}
