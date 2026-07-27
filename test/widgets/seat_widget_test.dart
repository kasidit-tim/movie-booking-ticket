import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/screens/seat_selection/bloc/seat_selection_bloc.dart';
import 'package:movie_booking_ticket/screens/seat_selection/views/widgets/seat_widget.dart';

/// Wraps a [SeatWidget] in a MaterialApp + BlocProvider so it can read
/// the bloc and access theme/text styles.
Widget _buildSubject({
  required SeatSelectionBloc bloc,
  required String seatNo,
  SeatStatus? status,
}) {
  return MaterialApp(
    theme: ThemeData.dark().copyWith(textTheme: AppTextTheme.textTheme),
    home: BlocProvider<SeatSelectionBloc>.value(
      value: bloc,
      child: Scaffold(
        body: SeatWidget(seatNo: seatNo, status: status),
      ),
    ),
  );
}

void main() {
  group('SeatWidget', () {
    late SeatSelectionBloc bloc;

    setUp(() {
      bloc = SeatSelectionBloc();
    });

    tearDown(() {
      bloc.close();
    });

    // ── Rendering ──────────────────────────────────────────────────

    testWidgets('displays seat number label', (tester) async {
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'A5'));
      expect(find.text('A5'), findsOneWidget);
    });

    testWidgets('renders available seat with card color', (tester) async {
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'A1'));

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.card);
    });

    testWidgets('renders selected seat with primary color', (tester) async {
      // Pre-select the seat in the bloc
      bloc.add(const ToggleSeatEvent('A1'));
      await tester.pump(); // Let the bloc process

      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'A1'));

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.primary);
    });

    testWidgets('renders reserved seat with cardSelected color',
        (tester) async {
      // G7 is in the default reserved set
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'G7'));

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.cardSelected);
    });

    // ── Explicit status override ───────────────────────────────────

    testWidgets('explicit status param overrides bloc state',
        (tester) async {
      // Seat A1 is available in bloc, but we force it to reserved
      await tester.pumpWidget(
        _buildSubject(bloc: bloc, seatNo: 'A1', status: SeatStatus.reserved),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.cardSelected);
    });

    // ── Tap behavior ───────────────────────────────────────────────

    testWidgets('tapping available seat dispatches ToggleSeatEvent',
        (tester) async {
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'B3'));

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(bloc.state.selectedSeats, contains('B3'));
    });

    testWidgets('tapping selected seat deselects it', (tester) async {
      // Select first
      bloc.add(const ToggleSeatEvent('B3'));
      await tester.pump();

      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'B3'));
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(bloc.state.selectedSeats, isNot(contains('B3')));
    });

    testWidgets('tapping reserved seat does not change selection',
        (tester) async {
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'G7'));

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      // G7 should NOT be in selectedSeats (tap is disabled for reserved)
      expect(bloc.state.selectedSeats, isNot(contains('G7')));
    });

    testWidgets('tapping empty seatNo does nothing', (tester) async {
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: ''));

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(bloc.state.selectedSeats, isEmpty);
    });

    // ── Visual state transitions ───────────────────────────────────

    testWidgets('seat color reflects bloc state changes via rebuild',
        (tester) async {
      BoxDecoration findSeatDecoration() {
        final seatFinder = find.byWidgetPredicate(
          (w) =>
              w is Container &&
              w.decoration is BoxDecoration &&
              (w.decoration as BoxDecoration).borderRadius ==
                  BorderRadius.circular(6),
        );
        return tester.widget<Container>(seatFinder).decoration as BoxDecoration;
      }

      // 1) Build with available seat
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'D4'));
      expect(findSeatDecoration().color, AppColors.card);

      // 2) Select via bloc, then rebuild the full widget tree
      bloc.add(const ToggleSeatEvent('D4'));
      await tester.pump();
      // Force full rebuild so context.select re-evaluates
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'D4'));
      expect(findSeatDecoration().color, AppColors.primary);
      expect(bloc.state.selectedSeats, contains('D4'));

      // 3) Deselect, rebuild again
      bloc.add(const ToggleSeatEvent('D4'));
      await tester.pump();
      await tester.pumpWidget(_buildSubject(bloc: bloc, seatNo: 'D4'));
      expect(findSeatDecoration().color, AppColors.card);
      expect(bloc.state.selectedSeats, isNot(contains('D4')));
    });
  });
}
