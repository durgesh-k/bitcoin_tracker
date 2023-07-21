import 'package:bitcoin_tracker/providers/price_provider.dart';
import 'package:bitcoin_tracker/screens/home.dart';
import 'package:bitcoin_tracker/utils/functions.dart';
import 'package:bitcoin_tracker/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PriceProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          builder: (context, child) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return ErrorScreen(errorDetails: errorDetails);
            };
            return ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, child!),
                maxWidth: getWidth(context),
                minWidth: 300,
                defaultScale: true,
                mediaQueryData:
                    MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
                breakpoints: [
                  const ResponsiveBreakpoint.resize(300, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(color: const Color(0xFFF5F5F5)));
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home(),
        ));
  }
}
