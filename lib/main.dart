import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:qr_code/ui/core/notification_screen/widgets/notification_detailed.dart';
import 'package:qr_code/utils/constants.dart';
import 'package:qr_code/utils/routes.dart';
import 'package:qr_code/utils/shared_pref.dart';

import 'data/services/shared_pref_helper.dart';
import 'domain/models/notification_model.dart';
import 'domain/models/payment_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize("0eda7f4e-c25e-4438-bdb3-4aea23a39541");
  OneSignal.Notifications.requestPermission(true);
  SharedPref().shared();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PaymentData.initialize(
    apiKey:
        "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1Rjek1ESTNMQ0p1WVcxbElqb2lNVGN4TkRJNU1UUTVOaTQ1TURZeE5qSWlmUS45c0dVbm9SMHhHSFNMeUEzNGx2d1VMVHNqWnpHMy1GU2FKZDZtV1hlNi1qa0hnVlpfdWtVRnJaekR3UTJVX1ptaFRjUkZHMjFPV2VCWDVZUk4wVjdFdw==",
    // (Required) getting it from dashboard Select Settings -> Account Info -> API Key
    iframeId: "840790",

    integrationCardId: "4562985",
  );
  await SharedPreferencesHelper.init();
  print("object${SharedPreferencesHelper.compoundName}");

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Constants.initSize(context);
    OneSignal.Notifications.addClickListener((event) {
      final notification = event.notification;
      NotificationModel notifications = NotificationModel(
          date: DateTime.now().toString(),
          time: DateTime.now().toString(),
          description: notification.body.toString(),
          id: notification.notificationId,
          // timestamp: DateTime.now(),
          title: notification.title.toString(),
          imageUrl: notification.bigPicture.toString());

      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => NotificationDetailed(
            notificationModel: notifications,
          ),
        ),
        (route) =>
            route.isFirst, // يحتفظ فقط بأول شاشة (الشاشة الأخيرة قبل الإشعار)
      );
    });

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) => Routes.onGenerate(settings),
    );
  }
}
