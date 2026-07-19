class PaymentMethod {
  const PaymentMethod({required this.name, required this.iconUrl});

  final String name;
  final String iconUrl;

  static const mockMethods = [
    PaymentMethod(
      name: 'PromptPay',
      iconUrl:
          'https://upload.wikimedia.org/wikipedia/commons/c/c5/PromptPay-logo.png',
    ),
    PaymentMethod(
      name: 'TrueMoney Wallet',
      iconUrl: 'https://s.isanook.com/hi/0/ud/286/1432809/tw.jpg',
    ),
    PaymentMethod(
      name: 'Rabbit LINE Pay',
      iconUrl:
          'https://pbs.twimg.com/profile_images/1248501636567142401/P9zhw0f4_400x400.jpg',
    ),
    PaymentMethod(
      name: 'Shopee Pay',
      iconUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS74rD-okxmYf-TqMpklB7u_BCH1qrYRlIbw03v5AkmReYVgojZvgTWtjx&s=10',
    ),
    PaymentMethod(
      name: 'Credit / Debit Card',
      iconUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8kxpAp6cXuezbFV3u5ePlkezuV81oeg2TWUSBvVEtVA&s=10',
    ),
  ];
}