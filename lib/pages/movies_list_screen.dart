import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_db/constants/constant.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/pages/detail_screen.dart';
import 'package:movie_db/services/api_service.dart';
import 'package:movie_db/packages/watch_list.dart';

class MoviesListScreen extends StatefulWidget{
  final String title;
  final String type;

  const MoviesListScreen({super.key, required this.title, required this.type});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late List<MovieListModel>? _movieListModel = [];
  late String typeDesc;

  @override
  void initState(){
    super.initState();
    _getData();
  }

  void _getData() async {
    if(widget.type == 'trendingMovies'){
      typeDesc = 'Movie';
      _movieListModel = (await ApiService().getTrendingMovies(typeDesc));
    }else if(widget.type == 'trendingTVShows'){
      typeDesc = 'TV Show';
      _movieListModel = (await ApiService().getTrendingTvShows(typeDesc));
    } else {
      typeDesc = 'Movie';
      _movieListModel = (await ApiService().getRecommendationMovie(typeDesc));
    }
    
    Future.delayed(Duration(microseconds: (0.5 * 1000).toInt())).then((value) => setState(() {
    }));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ]
              ),
              Expanded(
                child: _movieListModel == null || _movieListModel!.isEmpty ?
                  const Center(
                    child: CircularProgressIndicator(),
                  ) : LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth <= 502) {
                      return MobilePage(movieListModel: _movieListModel, type: typeDesc);
                    } else if(constraints.maxWidth <= 1200) {
                      return WebPage(gridCount: 4,movieListModel: _movieListModel, type: typeDesc);
                    } else {
                      return WebPage(gridCount: 6, movieListModel: _movieListModel, type: typeDesc);
                    }
                  },
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}


class MobilePage extends StatelessWidget {
  final String type;
  final List<MovieListModel>? movieListModel;

  const MobilePage({super.key, required this.type, required this.movieListModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: movieListModel!.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen(id: movieListModel![index].id, type: type);
            }));
          },
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 8.0, top: 6, bottom: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow:const [ 
                      BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.24),
                            blurRadius: 8,
                            spreadRadius: 0,
                            offset: Offset(
                              0,
                              3,
                            ),
                        ),
                      //you can set more BoxShadow() here
                      ],
                  ),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), 
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            Constants.imageBaseUrl + movieListModel![index].posterPath,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            height: 170,
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
                                movieListModel![index].voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 170,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 8),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            movieListModel![index].originalTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (movieListModel![index].releaseDate != "") ? DateTime.parse(movieListModel![index].releaseDate).year.toString() : "n.d.",
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            type,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 170,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: movieListModel != null && index < movieListModel!.length
                      ? WatchListButton(movie: movieListModel![index], type: type) : const SizedBox() ,
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

class WebPage extends StatelessWidget {
  final int gridCount;
  final String type;
  final List<MovieListModel>? movieListModel;

  const WebPage({super.key, required this.gridCount, required this.type, required this.movieListModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GridView.count(
        crossAxisCount: gridCount,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: movieListModel!.map((list) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(id: list.id, type: type);
              }));
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      Constants.imageBaseUrl + list.posterPath,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      height: 1000,
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
                          list.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top:0.0,
                      left: - 5.0,
                      child: Container(
                        width: (MediaQuery.of(context).size.width <= 1200 ) ? 28 : 38,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                          color: Color.fromARGB(200, 22, 44, 33),
                        ),
                        child: movieListModel != null && movieListModel!.isNotEmpty
                          ? WatchListButton(movie: list, type: type) : const SizedBox(),
                      ),
                    ),
                  ],
                ),
              )
            ),
          );
        }).toList(),
      )
    );
  }
}


class WatchListButton extends StatefulWidget {
  final MovieListModel movie;
  final String type;

  const WatchListButton({super.key, required this.movie, required this.type});

  @override
  // ignore: library_private_types_in_public_api
  _WatchListButtonState createState() => _WatchListButtonState();
}

class _WatchListButtonState extends State<WatchListButton> {
  bool isWatchList = false;

  @override
  void initState(){
    super.initState();
    _getIsWatchList();
  }
  
  void _getIsWatchList() async {
    List<MovieListModel> getSameMovie = WatchList.watchListMovie.where((movie) => movie.id == widget.movie.id)
      .map((movie) {
        movie.type = widget.type;
        return movie;
      })
      .toList();

    if(getSameMovie.isNotEmpty){
      isWatchList = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double iconSize = (mediaWidth <= 502) ? 20 : (mediaWidth >= 1200 ) ? 18 : 14;

    return IconButton(
      icon: Icon(
        isWatchList ? Icons.bookmark_added_rounded : Icons.bookmark_add_outlined,
        color: Colors.white,
        size: iconSize
      ),
      onPressed: () {
        setState(() {
            List<MovieListModel> getSameMovie = WatchList.watchListMovie.where((movie) => movie.id == widget.movie.id)
              .map((movie) {
                return movie;
              })
              .toList();

            if(getSameMovie.isEmpty){
              WatchList.watchListMovie.add(widget.movie);
              _showPopup('Tambahkan ke watchlist saya');
            }else{
              int indexToRemove = WatchList.watchListMovie.indexWhere((movie) => movie.id == widget.movie.id);
              WatchList.watchListMovie.removeAt(indexToRemove);
              _showPopup('Hapus ke watchlist saya');
            }

            isWatchList = !isWatchList;
        });
      },
    );
  }
}

void _showPopup(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
      
  );
}

