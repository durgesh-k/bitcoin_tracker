import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bitcoin_tracker/providers/price_provider.dart';
import 'package:bitcoin_tracker/utils/functions.dart';
import 'package:bitcoin_tracker/widgets/error.dart';
import 'package:bitcoin_tracker/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currency = "USD";
  List<String> currencyArray = ["USD", "GBP", "EUR"];
  @override
  Widget build(BuildContext context) {
    return Consumer<PriceProvider>(builder: (context, priceProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            kIsWeb ? "Bitcoin Tracker for Web" : 'Bitcoin Tracker',
            style: TextStyle(
                fontFamily: 'SemiBold',
                fontSize: 20,
                color: Colors.black.withOpacity(0.2)),
          ),
        ),
        body: priceProvider.loading!
            ? const Center(child: Loader())
            : priceProvider.error!
                ? const Center(child: Error())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getHeight(context) * 0.5,
                        child: Column(
                          children: [
                            Container(
                              height: 2,
                              width: getWidth(context),
                              color: Colors.grey.shade100,
                            ),
                            SizedBox(
                                height: getHeight(context) * 0.2,
                                child: Image.asset(
                                  'assets/bitcoin.png',
                                  fit: BoxFit.contain,
                                )),
                            SizedBox(
                              height: getHeight(context) * 0.05,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedFlipCounter(
                                  value: double.parse(priceProvider
                                      .price!.bpi[currency]!.rate
                                      .replaceFirst(',', '')),
                                  thousandSeparator: ',',
                                  decimalSeparator: '.',
                                  fractionDigits: 4,
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 1200),
                                  textStyle: const TextStyle(
                                    fontFamily: 'Bold',
                                    fontSize: 40,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  currency,
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 18,
                                      color: Colors.orange),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context) * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black.withOpacity(0.3)),
                                child: const Padding(
                                  padding: EdgeInsets.all(50.0),
                                  child: Text(
                                    ' ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              CupertinoPicker(
                                  itemExtent: 32.0,
                                  diameterRatio: 1,
                                  backgroundColor: Colors.white,
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      currency = currencyArray[value];
                                    });
                                  },
                                  //backgroundColor: Colors.white,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "USD",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "SemiBold",
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "GBP",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "SemiBold",
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "EUR",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "SemiBold",
                                            fontSize: 20),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      );
    });
  }
}
