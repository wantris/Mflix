// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_db/constants/constant.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/packages/watch_list.dart';
import 'package:movie_db/services/api_service.dart';
import 'package:movie_db/utils/alert.dart';

class DetailScreen extends StatefulWidget {
  final int id; 
  final String type;
  const DetailScreen({super.key, required this.id, required this.type});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

String getFullCompanyPath(image){
  if (image != '') {
    return Constants.imageBaseUrl + image;
  } else {
    return Constants.defaultCompanyPath; 
  }
}

String getFullPosterPath(mediaDetail) {
  if (mediaDetail?.posterPath != null) {
      return Constants.imageBaseUrl + mediaDetail!.posterPath;
    } else {
      return Constants.defaultPosterPath;
    }
}

String getFullBackdropPath(mediaDetail) {
  if (mediaDetail?.backdropPath != null) {
      return Constants.imageBaseUrl + mediaDetail!.backdropPath;
    } else {
      return Constants.defaultPosterPath;
    }
}

double? ratingConvert(mediaDetail) {
  return (mediaDetail?.voteAverage ?? 0) / 10 * 5;
}

String setGenres(mediaDetail) {
  var maxLength = 30;
  var genre = mediaDetail?.genres.take(3)
              .map((genre) => genre.name)
              .join(', ')?? '';
  

  if (genre.length > maxLength) {
    return genre.substring(0, maxLength) + '...';
  } else {
    return genre;
  }
}

int? getReleaseDate(mediaDetail){
  var releaseDate = 0;

  if(mediaDetail is MovieDetailModel){
    releaseDate = mediaDetail.releaseDate.year;
    }else{
    if(mediaDetail?.firstAirDate != null){
      releaseDate = mediaDetail?.firstAirDate.year;
    }
  }

  return releaseDate;
}

  MovieListModel convertToMovieListModel(mediaDetail, type) {
    return MovieListModel(
      id: mediaDetail!.id, 
      posterPath: mediaDetail!.posterPath, 
      originalTitle: (mediaDetail is MovieDetailModel) ? mediaDetail.originalTitle : mediaDetail?.originalName, 
      voteAverage: mediaDetail.voteAverage, 
      releaseDate: (mediaDetail is MovieDetailModel) ? mediaDetail.releaseDate.toString() : mediaDetail.firstAirDate.toString(), 
      type: type
    );
  }

class _DetailScreenState extends State<DetailScreen> {
  dynamic mediaDetail;

  @override
  void initState(){
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    if(widget.type == 'Movie'){
      ApiResponse<MovieDetailModel?> response = await getMovieById(widget.id.toString());
      if (response.code == 200) {
        mediaDetail = response.data;
      } else{
        Alert().showErrorDialog(context, response.message?? "Something error");
      }

    }else{
      ApiResponse<TvShowDetailModel?> response = await getTVShowById(widget.id.toString());
      if (response.code == 200) {
        mediaDetail = response.data;
      } else{
        Alert().showErrorDialog(context, response.message?? "Something error");
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (mediaDetail == null) ? 
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        ) : 
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 502) {
              return MobileDetailPage(mediaDetail: mediaDetail, type: widget.type);
            }
            else{
              return WebDetailPage(mediaDetail: mediaDetail!, type: widget.type);
            }
          },
        )
    );
  }
}


class DetailMovieScreen extends StatefulWidget {
  final dynamic mediaDetail;
  const DetailMovieScreen({super.key, required this.mediaDetail});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Plot',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.mediaDetail?.overview.toString()?? '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 11 : 15,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Watch Time',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${widget.mediaDetail?.runtime.toString()?? 0} Min',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 11 : 15,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Language',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.mediaDetail?.spokenLanguages.take(3)
                    .map((lang) => lang.englishName)
                    .join(', ')?? '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 11 : 15,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Country',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.mediaDetail?.productionCountries.take(3)
                    .map((country) => country.name)
                    .join(', ')?? '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 11 : 15,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Production',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: (widget.mediaDetail?.productionCompanies ?? [])
                        .where((company) => company.logoPath.isNotEmpty == true)
                        .map<Widget>((company) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.network(getFullCompanyPath(company.logoPath))
                            ), 
                          ),
                        );
                      }).toList(),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class DetailTVShowScreen extends StatefulWidget {
  final dynamic mediaDetail;
  const DetailTVShowScreen({super.key, required this.mediaDetail});

  @override
  State<DetailTVShowScreen> createState() => _DetailTVShowScreenState();
}

class _DetailTVShowScreenState extends State<DetailTVShowScreen> {

  String getFullSeasonPath(image){
    if (image != '') {
      return Constants.imageBaseUrl + image;
    } else {
      return Constants.defaultCompanyPath; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Plot',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.mediaDetail?.overview.toString()?? '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 11 : 15,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Season',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${widget.mediaDetail?.seasons.length?? 0} Seasons',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 11 : 15,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
              SizedBox(height: (MediaQuery.of(context).size.width <= 502) ? 10 : 0),
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: (widget.mediaDetail?.seasons ?? []).take(5)
                        .where((season) => season.posterPath != null)
                        .map<Widget>((season) {
                        return Padding(
                          padding: EdgeInsets.only(right: (MediaQuery.of(context).size.width <= 502) ? 3 : 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width <= 502) ? 20 : 40),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width <= 502) ? MediaQuery.of(context).size.width * 0.3 : 100,
                                  height: (MediaQuery.of(context).size.width <= 502) ? MediaQuery.of(context).size.width * 0.4 : 200,
                                  child: Image.network(getFullSeasonPath(season.posterPath))
                                ),
                                Positioned(
                                  top: (MediaQuery.of(context).size.width <= 502) ? 10.0 : 30,
                                  right: (MediaQuery.of(context).size.width <= 502) ? 10.0 : 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: const Color.fromARGB(200, 22, 44, 33),
                                    ),
                                    padding: const EdgeInsets.only(top: 2, bottom: 2, left: 7, right: 7),
                                    child: Text(
                                      '${season.episodeCount.toString()} eps' ,
                                      style: const TextStyle(
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ), 
                          ),
                        );
                      }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Language',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.mediaDetail?.spokenLanguages.take(3)
                    .map((lang) => lang.englishName)
                    .join(', ')?? '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 11 : 15,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Country',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.mediaDetail?.productionCountries.take(3)
                    .map((country) => country.name)
                    .join(', ')?? '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 11 : 15,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 20),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Production',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width <= 502) ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: (widget.mediaDetail?.productionCompanies ?? [])
                        .where((company) => company.logoPath.isNotEmpty == true)
                        .map<Widget>((company) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.network(getFullCompanyPath(company.logoPath))
                            ), 
                          ),
                        );
                      }).toList(),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class MobileDetailPage extends StatelessWidget {
  final String type;
  final dynamic mediaDetail;

  const MobileDetailPage({super.key, required this.type, required this.mediaDetail});

  @override
  Widget build(BuildContext context) {
    var originalTitle = (mediaDetail is MovieDetailModel) ? mediaDetail?.originalTitle??'' : mediaDetail?.originalName??'';
    return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    child: Stack(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center, 
                          children: <Widget>[
                            ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white, Colors.transparent],
                                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image.network(
                                getFullPosterPath(mediaDetail),
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                                height: 500,
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              child: Column(
                                children: [
                                  Text(
                                    getFirstFourWords(originalTitle),
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                  (originalTitle.split(' ').length > 4)
                                    ?
                                      Text(
                                        getAfterFirstFourWords(originalTitle),
                                        style: const TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ) 
                                    : Container(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                                        child: Text(
                                          getReleaseDate(mediaDetail).toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 2, right: 2, top: 5),
                                        child: Icon(
                                          Icons.circle_rounded,
                                          color: Colors.white,
                                          size: 5,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                                        child: Text(
                                          setGenres(mediaDetail),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 2, right: 2, top: 5),
                                        child: Icon(
                                          Icons.circle_rounded,
                                          color: Colors.white,
                                          size: 5,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                                        child: Text(
                                          type,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          (ratingConvert(mediaDetail) ?? 0).toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(255, 219, 205, 77)
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        RatingBarIndicator(
                                          rating: double.parse((ratingConvert(mediaDetail) ?? 0).toStringAsFixed(2)),
                                          itemCount: 5,
                                          itemSize: 16.0,
                                          unratedColor: Colors.white,
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Color.fromARGB(255, 219, 205, 77),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    '${mediaDetail?.voteCount.toString()?? 0} Votes',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ] 
                        )
                      ],
                    )
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color.fromARGB(80, 0, 0, 0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: const Color.fromARGB(80, 0, 0, 0),
                            child: mediaDetail != null
                                    ? WatchListButton(movie: convertToMovieListModel(mediaDetail, type), type: type) : const SizedBox(),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
              (type == 'Movie') 
                ? DetailMovieScreen(mediaDetail: mediaDetail) : 
                DetailTVShowScreen(mediaDetail: mediaDetail)
            ],
          ),
      );
  }
}

class WebDetailPage extends StatelessWidget {
  final String type;
  final dynamic mediaDetail;

  const WebDetailPage({super.key, required this.type, required this.mediaDetail});

  @override
  Widget build(BuildContext context) {
    var originalTitle = (mediaDetail is MovieDetailModel) ? mediaDetail?.originalTitle??'' : mediaDetail?.originalName??'';

    double responsiveFontSize(BuildContext context, double factor) {
      return MediaQuery.of(context).size.width * factor / 30;
    }

    return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    child: Stack(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center, 
                          children: <Widget>[
                            ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [Colors.white, Colors.transparent],
                                ).createShader(Rect.fromLTRB(5, 0, rect.width * 0.5, rect.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: ShaderMask(
                                shaderCallback: (rect) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.white, Colors.transparent],
                                  ).createShader(Rect.fromLTRB(5, 0, rect.width * 1, rect.height * 1));
                                },
                                child: Image.network(
                                    getFullBackdropPath(mediaDetail),
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                    height: MediaQuery.of(context).size.width * 0.5,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 50,
                                child: Column(
                                  children: [
                                    Text(
                                      getFirstFourWords(originalTitle),
                                      style: TextStyle(
                                        fontSize: responsiveFontSize(context, 0.8),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    (originalTitle.split(' ').length > 4)
                                    ?
                                      Text(
                                        getAfterFirstFourWords(originalTitle),
                                        style: TextStyle(
                                          fontSize: responsiveFontSize(context, 0.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ) 
                                    : Container(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                                          child: Text(
                                            getReleaseDate(mediaDetail).toString(),
                                            style: TextStyle(
                                              fontSize: responsiveFontSize(context, 0.4),
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                                          child: Icon(
                                            Icons.circle_rounded,
                                            color: Colors.white,
                                            size: responsiveFontSize(context, 0.4)
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                                          child: Text(
                                            setGenres(mediaDetail),
                                            style: TextStyle(
                                              fontSize: responsiveFontSize(context, 0.4),
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                                          child: Icon(
                                            Icons.circle_rounded,
                                            color: Colors.white,
                                            size: responsiveFontSize(context, 0.4),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                                          child: Text(
                                            type,
                                            style: TextStyle(
                                              fontSize: responsiveFontSize(context, 0.4),
                                              color: Colors.white
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            (ratingConvert(mediaDetail) ?? 0).toStringAsFixed(1),
                                            style: TextStyle(
                                              fontSize: responsiveFontSize(context, 0.4),
                                              color: const Color.fromARGB(255, 219, 205, 77)
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          RatingBarIndicator(
                                            rating: double.parse((ratingConvert(mediaDetail) ?? 0).toStringAsFixed(2)),
                                            itemCount: 5,
                                            itemSize: responsiveFontSize(context, 0.4),
                                            unratedColor: Colors.white,
                                            itemBuilder: (context, _) => const Icon(
                                              Icons.star,
                                              color: Color.fromARGB(255, 219, 205, 77),
                                          )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      '${mediaDetail?.voteCount.toString()?? 0} Votes',
                                      style: TextStyle(
                                        fontSize: responsiveFontSize(context, 0.3),
                                        color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ] 
                        )
                      ],
                    )
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color.fromARGB(80, 0, 0, 0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: const Color.fromARGB(80, 0, 0, 0),
                            child: mediaDetail != null
                                    ? WatchListButton(movie: convertToMovieListModel(mediaDetail, type), type: type) : const SizedBox(),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
              (type == 'Movie') 
                ? DetailMovieScreen(mediaDetail: mediaDetail) : 
                DetailTVShowScreen(mediaDetail: mediaDetail)
            ],
          ),
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
    return IconButton(
      icon: Icon(
        isWatchList ? Icons.bookmark_added_rounded : Icons.bookmark_add_outlined,
        color: Colors.white,
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

String getFirstFourWords(String input) {
  List<String> words = input.split(' ');
  if (words.length > 4) {
    return words.sublist(0, 4).join(' ');
  } else {
    return input;
  }
}

String getAfterFirstFourWords(String input) {
  List<String> words = input.split(' ');
  if (words.length > 4) {
    return words.sublist(4).join(' ');
  } else {
    return input;
  }
}
