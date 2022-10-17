import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screens/bloc_observer.dart';
import 'package:news/screens/home_page.dart';
import 'cubit/notification/notification_cubit.dart';
import 'data/repositories/notification/notification_repostory.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => NotificationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotificationCubit(
              notificationRepository: context.read<NotificationRepository>(),
            ),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
