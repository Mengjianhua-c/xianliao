import 'package:flutter/material.dart';
import 'package:xianliao/models/movie.dart';
import 'package:xianliao/blocs/bloc_provider.dart';
import 'package:xianliao/blocs/movies/movie_detail_bloc.dart';
import 'package:xianliao/widgets/movies/movie_hero.dart';
import 'package:xianliao/widgets/movies/movie_actors.dart';
import 'package:xianliao/widgets/movies/movie_summary.dart';
import 'package:xianliao/widgets/movies/movie_reviews.dart';

class MoviePage extends StatefulWidget {
  final arguments;
  MoviePage({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    print(this.arguments['movie'].toString());
    // final movie = Movie.fromJSON(this.arguments['movie']);
    // print(movie);
    final bloc = MovieDetailBloc(
        movieID: this.arguments['id'], breifMovie: this.arguments['movie']);
    return _MoviePageState(bloc: bloc);
  }
}

class _MoviePageState extends State<MoviePage> {
  final MovieDetailBloc bloc;
  Movie movie;
  TabContentType currentTabType = TabContentType.reviews;

  _MoviePageState({this.bloc});

  @override
  void initState() {
    movie = bloc.breifMovie;
    bloc.movie.listen((_movie) {
      setState(() {
        movie = _movie;
      });
    });
    print('moid: ${this.movie.title}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        body: BlocProvider(
          bloc: bloc,
          child: (() {
            if (movie == null) {
              return Center(
                child: Text('loading'),
              );
            } else {
              return NotificationListener<TabSwitchNotification>(
                onNotification: (notification) {
                  setState(() {
                    currentTabType = notification.tabContentType;
                  });
                },
                child: DefaultTabController(
                    length: 2,
                    child: SafeArea(
                        top: false,
                        child: CustomScrollView(
                          slivers: <Widget>[
                            MovieHero(),
                            SliverToBoxAdapter(
                              child: MovieSummary(),
                            ),
                            SliverToBoxAdapter(
                              child: MovieActors(),
                            ),
                            SliverPadding(
                              padding: EdgeInsets.all(7.0),
                            ),
                            MovieReviewTabbar(),
                            MovieReviewTabbarContent(
                              tabContentType: currentTabType,
                            ),
                          ],
                        ))),
              );
            }
          }()),
        ));
  }
}
