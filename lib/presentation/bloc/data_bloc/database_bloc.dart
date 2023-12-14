import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gforce/data/repository/news_repository.dart';
import 'database_event.dart';
import 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final NewsProvider newsProvider;

  DatabaseBloc(this.newsProvider) : super(NewsInitialState()) {
    on<LoadNewsEvent>((event, emit) async {
      emit(NewsInitialState());
      try {
        final newsList = await newsProvider.getNewsStream().first;
        emit(NewsLoadedState(newsList));
      } catch (e) {
        print('Ошибка при загрузке новостей: $e');
        emit(NewsErrorState());
      }
    });
  }
}
