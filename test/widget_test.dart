import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bitcoin_tracker/models/bitcoin_price.dart';
import 'package:bitcoin_tracker/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bitcoin_tracker/screens/home.dart';
import 'package:bitcoin_tracker/providers/price_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockPriceProvider extends PriceProvider {
  BitcoinPrice? _price;
  BitcoinPrice get price => _price!;
  @override
  Future<void> fetchPrice() async {
    _price = BitcoinPrice(
      time: 'Sample Updated Time',
      disclaimer: 'Sample Disclaimer',
      chartName: 'Sample Chart Name',
      bpi: {
        'USD': Currency(
          code: 'USD',
          symbol: '\$',
          rate: '50000.0',
          description: 'Sample Description',
          rateFloat: 50000.0,
        ),
        'GBP': Currency(
          code: 'GBP',
          symbol: '\$',
          rate: '50000.0',
          description: 'Sample Description',
          rateFloat: 50000.0,
        ),
        'EUR': Currency(
          code: 'EUR',
          symbol: '\$',
          rate: '50000.0',
          description: 'Sample Description',
          rateFloat: 50000.0,
        ),
      },
    );

    loading = false;
    error = false;
    notifyListeners();
  }
}

void main() {
  group('fetchPrice', () {
    test('Test API call', () async {
      final priceProvider = MockPriceProvider();

      await priceProvider.fetchPrice();

      expect(priceProvider.loading, false);

      if (priceProvider.error == true) {
        expect(priceProvider.error, true);
        expect(priceProvider.price, isNull);
      } else {
        expect(priceProvider.error, false);
        expect(priceProvider.price, isA<BitcoinPrice>());
      }
    });
  });
}
