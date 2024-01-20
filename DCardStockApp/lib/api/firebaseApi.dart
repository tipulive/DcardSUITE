import 'package:firebase_messaging/firebase_messaging.dart';
class FirebaseApi{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission for receiving push notifications (optional)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false

    );

    print('User granted permission: ${await _firebaseMessaging.getToken()}');
    print('User granted permission: ${settings.authorizationStatus}');

    // Handle incoming messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
    });
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    // Handle notification tap when the app is in the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.notification?.title}');
    });
  }
  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print('Handling background message: ${message.notification?.title}');
    // Handle the background message as needed
  }
}