import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:qr_code/screens/notification_screen/notification_screen.dart';
import 'package:qr_code/utils/routes.dart';
import 'package:qr_code/utils/shared_pref.dart';

import 'firebase_options.dart';
import 'models/notification_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize("0eda7f4e-c25e-4438-bdb3-4aea23a39541");
  OneSignal.Notifications.requestPermission(true);
  SharedPref().shared();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    OneSignal.Notifications.addClickListener(
      (event) {
        final notification = event.notification;
        List<NotificationModel> notifications = [
          NotificationModel(
              description: notification.body.toString(),
              tittle: notification.title.toString(),
              image: notification.bigPicture.toString())
        ];
        NotificationService.saveNotifications(notifications);
        NotificationService.saveLastNotifications(notifications);
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => NotificationScreen(
                tittle: notification.title!,
                description: notification.body!,
                imageUrl: notification.bigPicture ?? ''),
          ),
          (route) => false,
        );
      },
    );

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) => Routes.onGenerate(settings),
    );
  }
}
