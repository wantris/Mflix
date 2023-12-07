import 'package:flutter/material.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/pages/detail_screen.dart';
import 'package:movie_db/pages/movies_list_screen.dart';
import 'package:movie_db/services/api_service.dart';
import 'package:movie_db/constants/constant.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 16, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HomeScreenTitle(title: 'Trending Movies', type: 'trendingMovie'),
                TrendingMovies(),
                HomeScreenTitle(title: 'Trending TV Shows', type: 'trendingTVShows'),
                TrendingTVShows(),
                HomeScreenTitle(title: 'Recommended For You', type: 'recommended'),
                RecommendedMovies(),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenTitle extends StatefulWidget{
  final String title;
  final String type;

  const HomeScreenTitle({super.key, required this.title, required this.type});

  @override
  State<HomeScreenTitle> createState() => _HomeScreenTitleState();
}

class _HomeScreenTitleState extends State<HomeScreenTitle> {
  @override
  Widget build(BuildContext context) {
    return Container( //Trending TV Shows
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MoviesListScreen(title: widget.title, type: widget.type);
              }));
            },
            child: const Text(
              'Show All',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  } 
}


class TrendingMovies extends StatefulWidget{
  const TrendingMovies({super.key});

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  late List<MovieListModel>? _movieListModel = [];

  @override
  void initState(){
    super.initState();
    _getData();
  }

  void _getData() async {
    _movieListModel = (await ApiService().getTrendingMovies('Movie'));

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: _movieListModel == null || _movieListModel!.isEmpty ? 
        const Center(
          child: CircularProgressIndicator(),
        ) : 
        ListView.builder(
          itemCount: (_movieListModel != null) ? _movieListModel!.length.clamp(0, 10) : 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(id: _movieListModel![index].id, type: 'Movie');
                }));
              },
              child: Container(
                width: 150, 
                margin: const EdgeInsets.only(right: 8.0, top: 6),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          Constants.imageBaseUrl + _movieListModel![index].posterPath,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          height: 230,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                        Positioned(
                          top:10.0,
                          right: 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color.fromARGB(200, 22, 44, 33),
                            ),
                            padding: const EdgeInsets.only(top: 2, bottom: 2, left: 7, right: 7),
                            child: Text(
                              _movieListModel![index].voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            );
          },
        ),
    );
  }
}

class TrendingTVShows extends StatefulWidget{
  const TrendingTVShows({super.key});

  @override
  State<TrendingTVShows> createState() => _TrendingTVShowsState();
}

class _TrendingTVShowsState extends State<TrendingTVShows> {
  late List<MovieListModel>? _tvShowModel = [];

  @override
  void initState(){
    super.initState();
    _getData();
  }

  void _getData() async {
    _tvShowModel = (await ApiService().getTrendingTvShows('TV Show'));

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: _tvShowModel == null || _tvShowModel!.isEmpty ? 
        const Center(
          child: CircularProgressIndicator(),
        ) : 
        ListView.builder(
          itemCount: (_tvShowModel != null) ? _tvShowModel!.length.clamp(0, 10) : 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(id: _tvShowModel![index].id, type: 'TV Show');
                }));
              },
              child: Container(
                width: 150,
                margin: const EdgeInsets.only(right: 8.0, top: 6),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          Constants.imageBaseUrl + _tvShowModel![index].posterPath,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          height: 230,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                        Positioned(
                          top:10.0,
                          right: 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color.fromARGB(200, 22, 44, 33),
                            ),
                            padding: const EdgeInsets.only(top: 2, bottom: 2, left: 7, right: 7),
                            child: Text(
                              _tvShowModel![index].voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            );
          },
        ),
    );
  }
}

class RecommendedMovies extends StatefulWidget{
  const RecommendedMovies({super.key});

  @override
  State<RecommendedMovies> createState() => _RecommendedMoviesState();
}

class _RecommendedMoviesState extends State<RecommendedMovies> {
  late List<MovieListModel>? _movieListModel = [];

  @override
  void initState(){
    super.initState();
    _getData();
  }

  void _getData() async {
    _movieListModel = (await ApiService().getRecommendationMovie('Movie'));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: _movieListModel == null || _movieListModel!.isEmpty ? 
        const Center(
          child: CircularProgressIndicator(),
        ) : 
        ListView.builder(
          itemCount: (_movieListModel != null) ? _movieListModel!.length.clamp(0, 10) : 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(id: _movieListModel![index].id, type: 'Movie');
                }));
              },
              child: Container(
                width: 150,
                margin: const EdgeInsets.only(right: 8.0, top: 6),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          Constants.imageBaseUrl + _movieListModel![index].posterPath,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          height: 230,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                        Positioned(
                          top:10.0,
                          right: 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color.fromARGB(200, 22, 44, 33),
                            ),
                            padding: const EdgeInsets.only(top: 2, bottom: 2, left: 7, right: 7),
                            child: Text(
                              _movieListModel![index].voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            );
          },
        ),
    );
  }
}