import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_ticket/screens/seat_selection/bloc/seat_selection_bloc.dart';

void main() {
  group('SeatSelectionBloc', () {
    late SeatSelectionBloc bloc;

    setUp(() {
      bloc = SeatSelectionBloc();
    });

    tearDown(() {
      bloc.close();
    });

    // ── Initial state ──────────────────────────────────────────────

    test('initial state has no selected seats, date, or time', () {
      expect(bloc.state.selectedSeats, isEmpty);
      expect(bloc.state.selectedDate, isNull);
      expect(bloc.state.selectedTime, isNull);
    });

    test('initial state has default reserved seats G7-G12', () {
      expect(
        bloc.state.reservedSeats,
        equals({'G7', 'G8', 'G9', 'G10', 'G11', 'G12'}),
      );
    });

    test('initial totalPrice is zero', () {
      expect(bloc.state.totalPrice, 0.0);
    });

    test('initial isDateTimeSelected is false', () {
      expect(bloc.state.isDateTimeSelected, isFalse);
    });

    // ── ToggleSeatEvent ────────────────────────────────────────────

    blocTest<SeatSelectionBloc, SeatSelectionState>(
      'adds a seat when toggling an unselected seat',
      build: () => SeatSelectionBloc(),
      act: (bloc) => bloc.add(const ToggleSeatEvent('A1')),
      expect: () => [
        predicate<SeatSelectionState>(
          (s) => s.selectedSeats.contains('A1') && s.selectedSeats.length == 1,
        ),
      ],
    );

    blocTest<SeatSelectionBloc, SeatSelectionState>(
      'removes a seat when toggling an already-selected seat',
      build: () => SeatSelectionBloc(),
      seed: () => const SeatSelectionState(selectedSeats: {'A1', 'B3'}),
      act: (bloc) => bloc.add(const ToggleSeatEvent('A1')),
      expect: () => [
        predicate<SeatSelectionState>(
          (s) => !s.selectedSeats.contains('A1') && s.selectedSeats.length == 1,
        ),
      ],
    );

    blocTest<SeatSelectionBloc, SeatSelectionState>(
      'can select multiple seats sequentially',
      build: () => SeatSelectionBloc(),
      act: (bloc) {
        bloc.add(const ToggleSeatEvent('A1'));
        bloc.add(const ToggleSeatEvent('B5'));
        bloc.add(const ToggleSeatEvent('C9'));
      },
      expect: () => [
        // After A1
        predicate<SeatSelectionState>(
          (s) => s.selectedSeats.contains('A1') && s.selectedSeats.length == 1,
        ),
        // After B5
        predicate<SeatSelectionState>(
          (s) =>
              s.selectedSeats.containsAll(['A1', 'B5']) &&
              s.selectedSeats.length == 2,
        ),
        // After C9
        predicate<SeatSelectionState>(
          (s) =>
              s.selectedSeats.containsAll(['A1', 'B5', 'C9']) &&
              s.selectedSeats.length == 3,
        ),
      ],
    );

    blocTest<SeatSelectionBloc, SeatSelectionState>(
      'totalPrice updates correctly as seats are toggled',
      build: () => SeatSelectionBloc(),
      act: (bloc) {
        bloc.add(const ToggleSeatEvent('A1')); // 1 seat = 210
        bloc.add(const ToggleSeatEvent('A2')); // 2 seats = 420
        bloc.add(const ToggleSeatEvent('A1')); // 1 seat = 210
      },
      expect: () => [
        predicate<SeatSelectionState>((s) => s.totalPrice == 210),
        predicate<SeatSelectionState>((s) => s.totalPrice == 420),
        predicate<SeatSelectionState>((s) => s.totalPrice == 210),
      ],
    );

    // ── SelectDateEvent ────────────────────────────────────────────

    blocTest<SeatSelectionBloc, SeatSelectionState>(
      'sets the selected date',
      build: () => SeatSelectionBloc(),
      act: (bloc) {
        final date = DateTime(2026, 7, 25);
        bloc.add(SelectDateEvent(date));
      },
      expect: () => [
        predicate<SeatSelectionState>(
          (s) => s.selectedDate == DateTime(2026, 7, 25),
        ),
      ],
    );

    // ── SelectTimeEvent ────────────────────────────────────────────

    blocTest<SeatSelectionBloc, SeatSelectionState>(
      'sets the selected time',
      build: () => SeatSelectionBloc(),
      act: (bloc) => bloc.add(const SelectTimeEvent('14:30')),
      expect: () => [
        predicate<SeatSelectionState>((s) => s.selectedTime == '14:30'),
      ],
    );

    // ── isDateTimeSelected computed property ───────────────────────

    blocTest<SeatSelectionBloc, SeatSelectionState>(
      'isDateTimeSelected becomes true when both date and time are set',
      build: () => SeatSelectionBloc(),
      act: (bloc) {
        bloc.add(SelectDateEvent(DateTime(2026, 7, 25)));
        bloc.add(const SelectTimeEvent('14:30'));
      },
      expect: () => [
        predicate<SeatSelectionState>(
          (s) => s.selectedDate != null && s.selectedTime == null,
        ),
        predicate<SeatSelectionState>((s) => s.isDateTimeSelected),
      ],
    );

    // ── seatPrice constant ─────────────────────────────────────────

    test('seatPrice is 210 baht', () {
      expect(SeatSelectionState.seatPrice, 210.0);
    });

    // ── copyWith clearDate/clearTime flags ─────────────────────────

    test('copyWith clearDate resets date to null', () {
      final state = SeatSelectionState(
        selectedDate: DateTime(2026, 7, 25),
      );
      final cleared = state.copyWith(clearDate: true);
      expect(cleared.selectedDate, isNull);
    });

    test('copyWith clearTime resets time to null', () {
      final state = const SeatSelectionState(selectedTime: '14:30');
      final cleared = state.copyWith(clearTime: true);
      expect(cleared.selectedTime, isNull);
    });
  });
}
