import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screens/bloc_observer.dart';
import 'package:news/screens/home_page.dart';
import 'cubit/notification/notification_cubit.dart';
import 'data/models/notification/news_model.dart';
import 'data/repositories/notification/notification_repostory.dart';
import 'data/services/local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => NotificationRepository(),
      child: BlocProvider(
        create: (context) => NotificationCubit(
          notificationRepository: context.read<NotificationRepository>(),
        ),
        child: Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  Main({super.key}) {
    init();
  }

  @override
  State<Main> createState() => _MainState();
  void init() async {
    String? FCMToken = await FirebaseMessaging.instance.getToken();

    print("FCM TOKEN:$FCMToken");

    LocalNotificationService.localNotificationService;

    //Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      print("FOREGROUND:${remoteMessage.notification?.title}");
      saveNotificationAndShowLocal(remoteMessage);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("TERMINATED:${message?.notification?.title}");
      if (message != null) {
        saveNotificationAndShowLocal(message);
      }
    });
  }

  void saveNotificationAndShowLocal(RemoteMessage remoteMessage) {
    LocalNotificationService.localNotificationService
        .showNotification(remoteMessage);
    var data = remoteMessage.data;
    CachedNews cachedNews = CachedNews(
      newsImage: data["news_image"],
      createdAt: DateTime.now().toString(),
      newsTitle: data["news_title"],
      newsText: data["news_text"],
    );
    // BlocProvider.of<NotificationCubit>(context).insertNotification(cachedNews);
  }

  void saveNotification(RemoteMessage remoteMessage) {
    var data = remoteMessage.data;
    CachedNews cachedNews = CachedNews(
      newsImage: data["news_image"],
      createdAt: DateTime.now().toString(),
      newsTitle: data["news_title"],
      newsText: data["news_text"],
    );
    // BlocProvider.of<NotificationCubit>(context).insertNotification(cachedNews);
  }
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotificationCubit>(context).readSavedNews();
    return MaterialApp(
      home: HomePage(),
    );
  }
}
