import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merchant_mobile_app/routes.dart';
import 'package:merchant_mobile_app/theme/style.dart';

void main() {
  runApp(
    MerchantApp(),
  );
}

class MerchantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Loading is done, return the app:
    return MaterialApp(
      theme: appTheme(),
      title: "CSB Connect",
      initialRoute: SPLASH_ROUTE,
      routes: routes(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr', ''),
        const Locale('en', ''),
      ],
    );
  }
}