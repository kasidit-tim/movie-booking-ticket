import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/screens/main/my_ticket/data/booking_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(this._repository) : super(const PaymentState()) {
    on<ConfirmPaymentEvent>(_onConfirmPayment);
  }

  final BookingRepository _repository;

  Future<void> _onConfirmPayment(
    ConfirmPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    try {
      await Future.delayed(Duration(seconds: 2));
      await _repository.saveBooking(event.booking);
      emit(state.copyWith(status: PaymentStatus.success));
    } catch (e) {
      debugPrint('=====> ConfirmPayment error: $e');
      emit(
        state.copyWith(status: PaymentStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
