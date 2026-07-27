import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

/// A 1×1 transparent PNG used as a placeholder for network images in tests.
///
/// Generated once and reused for every intercepted request so that golden
/// tests produce deterministic output without real HTTP calls.
final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, // PNG header
  0x00, 0x00, 0x00, 0x0d, 0x49, 0x48, 0x44, 0x52, // IHDR chunk
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, // 1×1
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1f, 0x15, 0xc4, 0x89,
  0x00, 0x00, 0x00, 0x0a, 0x49, 0x44, 0x41, 0x54, // IDAT chunk
  0x78, 0x9c, 0x62, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01,
  0xe5, 0x27, 0xde, 0xfc,
  0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4e, 0x44, // IEND chunk
  0xae, 0x42, 0x60, 0x82,
]);

/// An [HttpOverrides] that intercepts every HTTP request and returns
/// a 1×1 transparent PNG.
///
/// Set this globally in `flutter_test_config.dart` to mock all network
/// image loading ([Image.network], `cached_network_image`, etc.) during
/// golden tests.
///
/// ```dart
/// HttpOverrides.global = MockHttpOverrides();
/// ```
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;

  @override
  String? userAgent;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _MockHttpClientRequest();

  // All other HttpClient members throw UnimplementedError.
  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'MockHttpOverrides: unhandled HttpClient method '
      '${invocation.memberName}',
    );
  }
}

class _MockHttpClientRequest implements HttpClientRequest {
  final _headers = _MockHttpHeaders();

  @override
  HttpHeaders get headers => _headers;

  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'MockHttpOverrides: unhandled HttpClientRequest method '
      '${invocation.memberName}',
    );
  }
}

class _MockHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => HttpStatus.ok;

  @override
  int get contentLength => kTransparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  X509Certificate? get certificate => null;

  @override
  HttpConnectionInfo? get connectionInfo => null;

  @override
  List<RedirectInfo> get redirects => [];

  @override
  List<Cookie> get cookies => [];

  @override
  bool get isRedirect => false;

  @override
  bool get persistentConnection => true;

  @override
  String get reasonPhrase => 'OK';

  @override
  HttpHeaders get headers => _MockHttpHeaders();

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([kTransparentImage]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'MockHttpOverrides: unhandled HttpClientResponse method '
      '${invocation.memberName}',
    );
  }
}

class _MockHttpHeaders implements HttpHeaders {
  @override
  List<String>? operator [](String name) => null;

  @override
  String? value(String name) => null;

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {}

  @override
  void remove(String name, [Object? value]) {}

  @override
  void removeAll(String name) {}

  @override
  void clear() {}

  @override
  bool get chunkedTransferEncoding => false;

  @override
  set chunkedTransferEncoding(bool value) {}

  @override
  int get contentLength => -1;

  @override
  set contentLength(int value) {}

  @override
  ContentType? get contentType => null;

  @override
  set contentType(ContentType? value) {}

  @override
  DateTime? get date => null;

  @override
  set date(DateTime? value) {}

  @override
  bool get persistentConnection => true;

  @override
  set persistentConnection(bool value) {}

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'MockHttpOverrides: unhandled HttpHeaders method '
      '${invocation.memberName}',
    );
  }
}
