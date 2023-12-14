import '../../data/models/news_model.dart';

class NewsEntity {
  final String title;
  final String description;
  final String image;
  final String category;
  final DateTime date;

  NewsEntity({
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.date,
  });

  bool get isRecent {
    return date.isAfter(DateTime.now().subtract(Duration(days: 30)));
  }

  factory NewsEntity.fromModel(News model) {
    return NewsEntity(
      title: model.title,
      description: model.description,
      image: model.image,
      category: model.category,
      date: DateTime.parse(model.date),
    );
  }
}
