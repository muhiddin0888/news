import 'package:bloc/bloc.dart';
import '../../data/models/notification/news_model.dart';
import '../../data/repositories/notification/notification_repostory.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    required this.notificationRepository,
  }) : super(NotificationInitial());

  final NotificationRepository notificationRepository;

  void readSavedNews() async {
    emit(GetNotificationProgress());
    try {
      List<CachedNews> news = await notificationRepository.getAllCachedNews();
      emit(GetNotificationInSuccess(news: news));
    } catch (error) {
      emit(GetNotificationInFailure(errorText: error.toString()));
    }
  }

  void insertNotification(CachedNews cachedNews) async {
    await notificationRepository.insertCachedNews(cachedNews: cachedNews);
    readSavedNews();
  }
}


