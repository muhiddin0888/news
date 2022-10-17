import '../../local_dataBase/local_db.dart';
import '../../models/notification/news_model.dart';

class NotificationRepository {
  Future<CachedNews> insertCachedNews({required CachedNews cachedNews}) async {
    return await LocalDatabase.insertCachedNews(cachedNews);
  }

  Future<List<CachedNews>> getAllCachedNews() async {
    return await LocalDatabase.getAllCachedNews();
  }
}
