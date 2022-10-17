const String newsTable = "news_table";

class NewsModel {
  static final List<String> values = [
    /// Add all fields
    id, newsTitle, newsImage, createdAt, newsText,
  ];
  static const String id = "_id";
  static const String newsTitle = "news_title";
  static const String newsImage = "news_image";
  static const String createdAt = "created_at";
  static const String newsText = "news_text";

  static fromJson(Map<String, dynamic> data) {}
}

class CachedNews {
  final int? id;
  final String newsTitle;
  final String newsImage;
  final String createdAt;
  final String newsText;

  CachedNews({
    this.id,
    required this.newsImage,
    required this.createdAt,
    required this.newsTitle,
    required this.newsText,
  });

  CachedNews copyWith({
    int? id,
    String? newsImage,
    String? createdAt,
    String? newsTitle,
    String? newsText,
  }) =>
      CachedNews(
        id: id ?? this.id,
        newsImage: newsImage ?? this.newsImage,
        createdAt: createdAt ?? this.createdAt,
        newsTitle: newsTitle ?? this.newsTitle,
        newsText: newsText ?? this.newsText,
      );

  static CachedNews fromJson(Map<String, Object?> json) => CachedNews(
        id: json[NewsModel.id] as int?,
        newsTitle: json[NewsModel.newsTitle] as String,
        newsImage: json[NewsModel.newsImage] as String,
        createdAt: json[NewsModel.createdAt] as String,
        newsText: json[NewsModel.newsText] as String,
      );

  Map<String, Object?> toJson() => {
        NewsModel.id: id,
        NewsModel.newsImage: newsImage,
        NewsModel.newsTitle: newsTitle,
        NewsModel.newsText: newsText,
        NewsModel.createdAt: createdAt,
      };

  @override
  String toString() => '''
        ID: $id 
        NEWS TITLE $newsTitle
        NEWS IMAGE $newsImage
        CREATED AT $createdAt
        NEWS DATA $newsText
      ''';
}
