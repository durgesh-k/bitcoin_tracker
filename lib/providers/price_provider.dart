import 'dart:convert';

import 'package:bitcoin_tracker/models/bitcoin_price.dart';
import 'package:bitcoin_tracker/utils/constants.dart';
import 'package:bitcoin_tracker/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PriceProvider extends ChangeNotifier {
  BitcoinPrice? _price;
  bool? loading = true;
  bool? error = false;

  BitcoinPrice? get price => _price;

  PriceProvider() {
    fetchPrice();
  }

  Future<void> fetchPrice() async {
    try {
      final url = Uri.parse(apiUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final bitcoinPrice = BitcoinPrice.fromJson(jsonData);
        _price = bitcoinPrice;
        loading = false;
        notifyListeners();
      } else {
        loading = false;
        error = true;
        notifyListeners();
        showToast("Error loading data");
        throw Exception('Failed to fetch Bitcoin price');
      }
    } catch (e) {
      loading = false;
      error = true;
      notifyListeners();
      showToast("Error loading data");
    }
  }
}
