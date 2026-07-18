import 'dart:math';

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String generateOrderId() {
  final random = Random();
  return List.generate(11, (_) => random.nextInt(10)).join();
}

String formatBookingDateTime(DateTime date, String? time) {
  return '$time • ${date.day.toString().padLeft(2, '0')}.${_months[date.month - 1]}.${date.year}';
}