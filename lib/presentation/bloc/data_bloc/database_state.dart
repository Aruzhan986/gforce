import 'package:flutter_gforce/data/repository/news_repository.dart';

abstract class DatabaseState {}

class NewsInitialState extends DatabaseState {}

class NewsLoadedState extends DatabaseState {
  final List<News> newsList;

  NewsLoadedState(this.newsList);
}

class NewsErrorState extends DatabaseState {}
