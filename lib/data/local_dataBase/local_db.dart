import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/notification/news_model.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("news.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE $newsTable (
    ${NewsModel.id} $idType,
    ${NewsModel.createdAt} $textType,
    ${NewsModel.newsImage} $textType,
    ${NewsModel.newsText} $textType,
    ${NewsModel.newsTitle} $textType
    )
    ''');
  }

  LocalDatabase._init();

  //-------------------------------------------Cached News Table------------------------------------

  static Future<CachedNews> insertCachedNews(CachedNews cachedTodo) async {
    final db = await getInstance.database;
    final id = await db.insert(newsTable, cachedTodo.toJson());
    return cachedTodo.copyWith(id: id);
  }

  static Future<List<CachedNews>> getAllCachedNews() async {
    final db = await getInstance.database;
    const orderBy = '${NewsModel.newsTitle} DESC';
    final result = await db.query(newsTable, orderBy: orderBy);
    return result.map((json) => CachedNews.fromJson(json)).toList();
  }
}
