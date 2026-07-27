import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:movie_booking_ticket/core/theme/app_theme.dart';

/// Wraps [child] in a [MaterialApp] with the real app theme.
///
/// Optionally supplies [BlocProvider]s via [blocProviders] so that
/// screens depending on BLoCs can be tested in isolation.
///
/// ```dart
/// await tester.pumpWidget(
///   createTestApp(
///     MyScreen(),
///     blocProviders: [BlocProvider.value(value: myBloc)],
///   ),
/// );
/// ```
Widget createTestApp(
  Widget child, {
  ThemeData? theme,
  List<BlocProvider>? blocProviders,
}) {
  Widget wrapped = child;

  if (blocProviders != null && blocProviders.isNotEmpty) {
    wrapped = MultiBlocProvider(
      providers: blocProviders,
      child: wrapped,
    );
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme ?? AppTheme.dark,
    home: wrapped,
  );
}

/// Pumps [child] wrapped with [createTestApp], then calls
/// [WidgetTester.pumpAndSettle].
///
/// [multiScreen] (defaults to `true`) also runs [multiScreenGolden]
/// across [GoldenDevices.devices].
///
/// Use this for simple golden tests; for custom pumping sequences
/// (e.g. animations, timed state changes) call [createTestApp] and
/// pump manually.
Future<void> pumpTestApp(
  WidgetTester tester,
  Widget child, {
  ThemeData? theme,
  List<BlocProvider>? blocProviders,
  bool multiScreen = false,
  String? goldenFileName,
}) async {
  await tester.pumpWidget(
    createTestApp(
      child,
      theme: theme,
      blocProviders: blocProviders,
    ),
  );
  await tester.pumpAndSettle();

  if (multiScreen && goldenFileName != null) {
    await multiScreenGolden(
      tester,
      goldenFileName,
      devices: const [Device.phone, Device.tabletPortrait],
    );
  }
}
