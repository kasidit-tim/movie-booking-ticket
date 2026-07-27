import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Reusable device presets for golden tests.
///
/// Provides a consistent set of screen sizes across all golden tests
/// so that device definitions are centralized and easy to update.
class GoldenDevices {
  GoldenDevices._();

  /// Standard phone: iPhone-sized (375×812, 3×).
  static const phone = Device.phone;

  /// Tablet in portrait: iPad-sized (1024×1366, 2×).
  static const tablet = Device.tabletPortrait;

  /// Small phone: iPhone SE sized (375×667, 2×).
  static const smallPhone = Device(
    size: Size(375, 667),
    name: 'small',
    devicePixelRatio: 2,
  );

  static const iphone17 = Device(name: 'iphone17', size: Size(402, 874));

  /// All devices commonly used in golden tests.
  static const devices = [phone, tablet];

  /// All devices including the small-phone variant.
  static const allDevices = [phone, smallPhone, tablet];
}
