part of 'payment_bloc.dart';

enum PaymentStatus { initial, loading, success, error }

class PaymentState extends Equatable {
  const PaymentState({
    this.status = PaymentStatus.initial,
    this.errorMessage,
  });

  final PaymentStatus status;
  final String? errorMessage;

  PaymentState copyWith({PaymentStatus? status, String? errorMessage}) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}