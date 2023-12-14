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
