import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cinema.g.dart';

@JsonSerializable()
class Cinema extends Equatable {
  const Cinema({
    required this.id,
    required this.name,
    required this.distance,
    required this.address,
  });

  final int id;
  final String name;
  final String distance;
  final String address;

  factory Cinema.fromJson(Map<String, dynamic> json) =>
      _$CinemaFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaToJson(this);

  static const mockCinemas = [
    Cinema(
      id: 1,
      name: 'Major Cineplex Ratchayothin',
      distance: '3.2 km',
      address: '123 Phahonyothin Rd, Chatuchak, Bangkok',
    ),
    Cinema(
      id: 2,
      name: 'SF Cinema MBK Center',
      distance: '5.8 km',
      address: '444 Phaya Thai Rd, Wang Mai, Pathum Wan, Bangkok',
    ),
    Cinema(
      id: 3,
      name: 'Siam Paragon Cineplex',
      distance: '6.1 km',
      address: '991 Rama 1 Rd, Pathum Wan, Bangkok',
    ),
    Cinema(
      id: 4,
      name: 'Quartier CineArt',
      distance: '8.4 km',
      address: '689 Sukhumvit Rd, Khlong Tan Nuea, Watthana, Bangkok',
    ),
    Cinema(
      id: 5,
      name: 'Emprivé Cineplex Emporium',
      distance: '9.0 km',
      address: '622 Sukhumvit Rd, Khlong Ton, Khlong Toei, Bangkok',
    ),
  ];

  @override
  List<Object> get props => [id, name, distance, address];
}
