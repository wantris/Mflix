import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db/constants/constant.dart';
import 'package:movie_db/models/movie_model.dart';

class ApiService {
  Future<List<MovieListModel>?> getTrendingMovies(String type) async {
    final url = Uri.parse(Constants.baseUrl + Constants.trendingMovie);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${Constants.apiKey}',
          'Content-Type': 'application/json',
        }
      );
      if(response.statusCode == 200){
        List<MovieListModel> model = movieListModelFromJson(response.body, type);
        return model;
      } else {
        throw Exception('Failed to get trending movices');
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<MovieListModel>?> getTrendingTvShows(String type) async {
    final url = Uri.parse(Constants.baseUrl + Constants.trendingTVShow);
    try {
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${Constants.apiKey}',
            'Content-Type': 'application/json',
          }
        );
        if(response.statusCode == 200){
          List<MovieListModel> model = movieListModelFromJson(response.body, type);
          return model;
        } else {
          throw Exception('Failed to get trending tv shows');
        }  
      } catch (e) {
        return null;
      }
  }

  Future<List<MovieListModel>?> getRecommendationMovie(String type) async {
    final url = Uri.parse(Constants.baseUrl + Constants.recommendedMovies);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${Constants.apiKey}',
          'Content-Type': 'application/json',
        }
      );
      if(response.statusCode == 200){
        List<MovieListModel> model = movieListModelFromJson(response.body, type);
        return model;
      } else {
        throw Exception('Failed to get recomendation movies');
      }
    } catch (e) {
      return null;
    }
  }
}

class ApiResponse<T> {
  final int? code;
  final String? message;
  final T? data;

  ApiResponse({this.code, this.message, this.data});
}

Future<ApiResponse<MovieDetailModel?>> getMovieById(String id) async {
  final url = Uri.parse(Constants.baseUrl + Constants.movieDetail + id.toString());
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Content-Type': 'application/json',
      }
    );

    final Map<String, dynamic> data = json.decode(response.body);
    if(response.statusCode == 200){
      final MovieDetailModel movieDetailModel = MovieDetailModel.fromJson(data);
      return ApiResponse(code: response.statusCode, message: 'success', data: movieDetailModel);
    } else {
      return ApiResponse(code:response.statusCode, message: data['status_message'], data: null);
    }

  } catch (e) {
    return ApiResponse(code:500, message: 'Internal Server Errror', data: null);
  }
}

Future<ApiResponse<TvShowDetailModel?>> getTVShowById(String id) async {
  final url = Uri.parse(Constants.baseUrl + Constants.tvShowDetail + id.toString());
  
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Content-Type': 'application/json',
      }
    );

    final Map<String, dynamic> data = json.decode(response.body);
    if(response.statusCode == 200){
      final TvShowDetailModel tvShowDetailModel = TvShowDetailModel.fromJson(data);
      return ApiResponse(code: response.statusCode, message: 'success', data: tvShowDetailModel);
    } else {
      return ApiResponse(code:response.statusCode, message: data['status_message'], data: null);
    }
  } catch (e) {
    return ApiResponse(code:500, message: 'Internal Server Errror', data: null);
  }
}