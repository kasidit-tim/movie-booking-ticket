class TicketDetailData {
  const TicketDetailData({
    required this.movieTitle,
    required this.posterUrl,
    required this.duration,
    required this.genres,
    required this.showTime,
    required this.showDate,
    required this.section,
    required this.seats,
    required this.price,
    required this.cinemaName,
    required this.cinemaAddress,
    required this.orderId,
    this.note =
        'Show this QR code to the ticket counter to receive your ticket',
  });

  final String movieTitle;
  final String posterUrl;
  final String duration;
  final String genres;
  final String showTime;
  final String showDate;
  final int section;
  final List<String> seats;
  final num price;
  final String cinemaName;
  final String cinemaAddress;
  final String orderId;
  final String note;
}
