import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/view_model/locale_provider.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/account_provider.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/order_provider.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/seller/view_model/seller_registration_provider.dart';
import 'package:labees/features/settings/view_model/settings_provider.dart';
import 'package:labees/features/splash/splash_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => CartProvider()),
          ChangeNotifierProvider(create: (context) => CheckoutProvider()),
          ChangeNotifierProvider(create: (context) => AccountProvider()),
          ChangeNotifierProvider(create: (context) => OrderProvider()),
          ChangeNotifierProvider(create: (context) => LocaleProvider()),
          ChangeNotifierProvider(create: (context) => SellerRegistrationProvider()),
          ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ],

        child: const MyApp()
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Labees',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
        ),
      ),
      locale: context.watch<LocaleProvider>().appLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // Add other delegates as needed
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
        // Add other supported locales
      ],
      builder: EasyLoading.init(),
      home: const SplashScreen(),
    );
  }
}
