import 'dart:convert';
import 'dart:io';

/// Loads a JSON fixture from the test/goldens/fixtures directory.
///
/// [path] is relative to `test/goldens/fixtures/`, e.g. `'home/now_playing.json'`.
///
/// Returns the decoded JSON as a [Map] for objects or [List] for arrays.
dynamic loadFixture(String path) {
  final file = File('test/goldens/fixtures/$path');
  final json = file.readAsStringSync();
  return jsonDecode(json);
}

/// Convenience wrapper that always returns a [Map<String, dynamic>].
Map<String, dynamic> loadFixtureMap(String path) {
  return loadFixture(path) as Map<String, dynamic>;
}

/// Convenience wrapper that always returns a [List<dynamic>].
List<dynamic> loadFixtureList(String path) {
  return loadFixture(path) as List<dynamic>;
}
