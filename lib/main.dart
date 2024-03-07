import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


void main() async { 

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //notification permission

  //await Permission.notification.request();
  //await Permission.location.request();


  //if(Platform.isAndroid) {

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token;

    token = await messaging.getToken();

    log('fcm token: $token');


    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );


    flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;


      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.title}');
        print('Message also contained a notification: ${message.notification!.body}');

        var initializationSettingsAndroid = const AndroidInitializationSettings('mipmap/ic_launcher');


        if (android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: initializationSettingsAndroid.defaultIcon,
                ),
              ));
        }

      }
    });


  //}


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

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          '1',
          'test',
          //channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
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
          background: const Color(0xFFFFFFFF),

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
