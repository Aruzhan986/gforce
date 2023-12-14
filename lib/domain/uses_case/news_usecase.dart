import 'package:flutter_gforce/data/repository/news_repository.dart';

class GetNewsStreamUseCase {
  final NewsRepository repository;

  GetNewsStreamUseCase(this.repository);

  Stream<List<News>> call() {
    return repository.getNewsStream();
  }
}
