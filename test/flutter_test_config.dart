import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Flutter test configuration entry-point.
///
/// Called automatically by the test runner before any test file executes.
/// Sets up:
/// 1. Custom fonts via [loadAppFonts] (SF Pro Display).
/// 2. Mock platform channels for `path_provider` so that
///    `flutter_cache_manager` (used by `cached_network_image`) works
///    without real platform plugins.
/// 3. Golden toolkit configuration with deterministic file naming.
///
/// Network images are mocked per-test using `mockNetworkImages()` from
/// `mocktail_image_network` package.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Load the app's custom fonts (SF Pro Display) so golden tests
  // render text identically to production.
  await loadAppFonts();

  // Register a mock handler for the path_provider platform channel.
  // cached_network_image → flutter_cache_manager calls these methods
  // to locate its on-disk cache; without this stub they throw
  // MissingPluginException.
  const pathProviderChannel = MethodChannel('plugins.flutter.io/path_provider');
  final tempDir = Directory.systemTemp.createTempSync('mbt_test_');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(pathProviderChannel, (call) async {
        switch (call.method) {
          case 'getTemporaryDirectory':
            return tempDir.path;
          case 'getApplicationSupportDirectory':
            return tempDir.path;
          case 'getApplicationDocumentsDirectory':
            return tempDir.path;
          default:
            return null;
        }
      });

  return GoldenToolkit.runWithConfiguration(
    testMain,
    config: GoldenToolkitConfiguration(
      // Device-specific goldens go into a `goldens/` sub-directory.
      deviceFileNameFactory: (name, device) =>
          'goldens/$name.${device.name}.png',
      // Single-device goldens also land in `goldens/`.
      fileNameFactory: (name) => 'goldens/$name.png',
      // Always compare — never skip golden assertions.
      skipGoldenAssertion: () => false,
      // Disable automatic asset priming since we mock network images
      // via HttpOverrides and don't need the default asset priming pass.
      primeAssets: (_) async {},
    ),
  );
}
