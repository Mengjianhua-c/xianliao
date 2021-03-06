import 'package:flutter/material.dart';
import 'package:xianliao/models/movie.dart';
import 'package:xianliao/blocs/bloc_provider.dart';
import 'package:xianliao/blocs/movies/movie_detail_bloc.dart';

class MovieHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MovieDetailBloc>(context);

    return StreamBuilder<Movie>(
      stream: bloc.movie,
      initialData: bloc.breifMovie,
      builder: (context, snapshot) {
        final Movie movie = snapshot.data;
        print('xxxxxxxx: ${movie.title}');
        return SliverAppBar(
          // title: Text(movie.title),
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(movie.title),
            background: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Positioned.fill(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.network(
                    movie.poster,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    // colors: [Color(222), Color(100), Color(111)],
                  )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
