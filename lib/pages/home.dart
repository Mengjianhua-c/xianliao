import 'package:flutter/material.dart';
import 'package:xianliao/widgets/movies/movies.dart';
import 'package:xianliao/blocs/movies/movie_item_bloc.dart';

class _BadgeWidget extends StatelessWidget {
  final int count;

  _BadgeWidget({this.count});

  @override
  Widget build(BuildContext context) {
    if (count > 0) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: Colors.red,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  Set<String> favoriteMovies = Set();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<FavoriteNotification>(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Douban Movie Top 250'),
            actions: <Widget>[
              _BadgeWidget(
                count: favoriteMovies.length,
              )
            ],
          ),
          body: Movies(),
        ),
        onNotification: (FavoriteNotification notification) {
          if (notification.isFavorite) {
            favoriteMovies.add(notification.movie.id);
            // ignore: missing_return
          } else {
            favoriteMovies.remove(notification.movie.id);
          }
        });
  }
}

class Home1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home1State();
  }
}

class _Home1State extends State<Home1> {
  Set<String> favoriteMovies = Set();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<FavoriteNotification>(
        child: Container(
          child: Movies(),
        ),
        onNotification: (FavoriteNotification notification) {
          if (notification.isFavorite) {
            favoriteMovies.add(notification.movie.id);
            // ignore: missing_return
          } else {
            favoriteMovies.remove(notification.movie.id);
          }
        });
  }
}
