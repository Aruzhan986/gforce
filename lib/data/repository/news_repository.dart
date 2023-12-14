import 'package:firebase_database/firebase_database.dart';

class NewsProvider {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  Stream<List<News>> getNewsStream() {
    DatabaseReference ref = database.ref();

    return ref.onValue.map((event) {
      final dynamic value = event.snapshot.value;
      print('Firebase data: $value');
      final List<News> newsList = [];
      if (value is List) {
        for (var item in value) {
          if (item is Map) {
            final newsMap = Map<String, dynamic>.from(item);
            print('News item before conversion: $newsMap');
            final news = News.fromMap(newsMap);
            newsList.add(news);
          } else {
            print('Invalid format for news item: $item');
          }
        }
      } else {
        print(
            'The retrieved Firebase value is not a List. Actual type: ${value.runtimeType}');
      }
      return newsList;
    });
  }
}

abstract class NewsRepository {
  Stream<List<News>> getNewsStream();
}

class News {
  final String title;
  final String description;
  final String image;
  final String category;
  final String date;

  News({
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.date,
  });

  factory News.fromMap(Map<String, dynamic> map) {
    print('Creating a News item from: $map');
    return News(
      title: map['title'] ?? 'Default Title',
      description: map['description'] ?? 'Default Description',
      image: map['image'] ?? 'assets/images/default_image.jpg',
      category: map['category'] ?? 'Default Category',
      date: map['date'] ?? 'Default Date',
    );
  }
}
