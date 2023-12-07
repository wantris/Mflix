import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_db/constants/constant.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/packages/watch_list.dart';
import 'package:movie_db/pages/detail_screen.dart';

class FavouriteScreen extends StatefulWidget{

  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final List<MovieListModel>? watchListModel = WatchList.watchListMovie;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: watchListModel == null || watchListModel!.isEmpty ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/icons/empty-icon.svg',
                      semanticsLabel: 'Empty Icon',
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ),
                  const Text(
                    'Add more items to my watch list',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                    ),
                  )
                ],
              ),
            )
          ],
        ) :
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: watchListModel!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                            final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              DetailScreen(id: watchListModel![index].id, type: watchListModel![index].type)
                            ));

                            if (result == null || result) {
                              setState(() {});
                            }
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
                                            Constants.imageBaseUrl + watchListModel![index].posterPath,
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
                                                watchListModel![index].voteAverage.toStringAsFixed(1),
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
                                            watchListModel![index].originalTitle,
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
                                            (watchListModel![index].releaseDate != "null") ? DateTime.parse(watchListModel![index].releaseDate).year.toString() : "n.d.",
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
                                            watchListModel![index].type,
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
                            ],
                          ),
                        );
                      }
                    ),
                ),
              ]
            ),
          ),
        ),
    );
  }
}

