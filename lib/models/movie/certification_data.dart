import 'package:json_annotation/json_annotation.dart';

part 'certification_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CertificationData {
  final List<CountryReleaseDates> results;

  CertificationData({this.results = const []});

  factory CertificationData.fromJson(Map<String, dynamic> json) =>
      _$CertificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationDataToJson(this);

  String forCountry(String iso31661) {
    for (final country in results) {
      if (country.iso31661 == iso31661) {
        for (final entry in country.releaseDates) {
          if (entry.certification.isNotEmpty) return entry.certification;
        }
      }
    }
    return '';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CountryReleaseDates {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final List<ReleaseDateEntry> releaseDates;

  CountryReleaseDates({this.iso31661 = '', this.releaseDates = const []});

  factory CountryReleaseDates.fromJson(Map<String, dynamic> json) =>
      _$CountryReleaseDatesFromJson(json);

  Map<String, dynamic> toJson() => _$CountryReleaseDatesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReleaseDateEntry {
  final String certification;
  ReleaseDateEntry({this.certification = ''});

  factory ReleaseDateEntry.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDateEntryFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseDateEntryToJson(this);
}
