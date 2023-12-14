import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/data_bloc/database_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/data_bloc/database_event.dart';
import 'package:flutter_gforce/presentation/bloc/data_bloc/database_state.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late List<bool> likes;

  @override
  void initState() {
    super.initState();
    context.read<DatabaseBloc>().add(LoadNewsEvent());
    likes = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: PrimaryGradients.primaryGradient),
        child: BlocBuilder<DatabaseBloc, DatabaseState>(
          builder: (context, state) {
            if (state is NewsInitialState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewsLoadedState) {
              if (state.newsList.isEmpty) {
                return Center(child: Text('Нет данных.'));
              }
              if (likes.isEmpty) {
                likes = List.generate(state.newsList.length, (index) => false);
              }
              return ListView.builder(
                itemCount: state.newsList.length,
                itemBuilder: (context, index) {
                  final newsItem = state.newsList[index];
                  return AnimatedNewsCard(newsItem, index);
                },
              );
            } else if (state is NewsErrorState) {
              return Center(child: Text('Ошибка загрузки новостей'));
            } else {
              return Center(child: Text('Неизвестное состояние'));
            }
          },
        ),
      ),
    );
  }

  Widget AnimatedNewsCard(newsItem, index) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(seconds: 1),
      child: NewsCard(newsItem, index),
    );
  }

  Widget NewsCard(newsItem, index) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              newsItem.image,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              newsItem.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(newsItem.description),
          ),
          LikeButton(index),
        ],
      ),
    );
  }

  Widget LikeButton(index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(
          likes[index] ? Icons.favorite : Icons.favorite_border,
          color:
              likes[index] ? PrimaryColors.Coloreight : PrimaryColors.Colorten,
        ),
        onPressed: () {
          setState(() {
            likes[index] = !likes[index];
          });
        },
      ),
    );
  }
}
