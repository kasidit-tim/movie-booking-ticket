import 'dart:convert';

import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingRepository {
  BookingRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _key = 'saved_bookings';

  Future<void> saveBooking(BookingData booking) async {
    final list = getBookings();
    list.insert(0, booking);
    final json = jsonEncode(list.map((b) => b.toJson()).toList());
    await _prefs.setString(_key, json);
  }

  List<BookingData> getBookings() {
    final json = _prefs.getString(_key);
    if (json == null) return [];
    final list = jsonDecode(json) as List;
    return list.map((e) => BookingData.fromJson(e as Map<String, dynamic>)).toList();
  }
}