class BitcoinPrice {
  final String time;
  final String disclaimer;
  final String chartName;
  final Map<String, Currency> bpi;

  BitcoinPrice({
    required this.time,
    required this.disclaimer,
    required this.chartName,
    required this.bpi,
  });

  factory BitcoinPrice.fromJson(Map<String, dynamic> json) {
    final time = json['time']['updated'];
    final disclaimer = json['disclaimer'];
    final chartName = json['chartName'];
    final bpi = json['bpi'] as Map<String, dynamic>;

    final Map<String, Currency> currencies = {};
    bpi.forEach((key, value) {
      currencies[key] = Currency.fromJson(value);
    });

    return BitcoinPrice(
      time: time,
      disclaimer: disclaimer,
      chartName: chartName,
      bpi: currencies,
    );
  }
}

class Currency {
  final String code;
  final String symbol;
  final String rate;
  final String description;
  final double rateFloat;

  Currency({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      symbol: json['symbol'],
      rate: json['rate'],
      description: json['description'],
      rateFloat: json['rate_float'].toDouble(),
    );
  }
}
