import 'dart:convert';

// Movie List Model
List<MovieListModel> movieListModelFromJson(String str, String type) {
  final jsonData = json.decode(str);
  if (jsonData != null) {
    return List<MovieListModel>.from(jsonData['results'].map((x) => MovieListModel.fromJson(x, type)));
  } else {
    throw Exception('Invalid JSON structure - missing "results" key.');
  }
}

String movieListModelToJson(List<MovieListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


// Movie Detail model
MovieDetailModel movieDetailModelFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData != null) {
    return MovieDetailModel.fromJson(json.decode(str));
  } else {
    throw Exception('Invalid JSON structure - missing "results" key.');
  }
}

String movieDetailModelToJson(MovieDetailModel data) => json.encode(data.toJson());

// TV Detail Model
TvShowDetailModel tvShowDetailModelFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData != null) {
    return TvShowDetailModel.fromJson(json.decode(str));
  } else {
    throw Exception('Invalid JSON structure - missing "results" key.');
  }
}

String tvShowDetailModelToJson(TvShowDetailModel data) => json.encode(data.toJson());

class MovieListModel {
  MovieListModel({
    required this.id,
    required this.originalTitle,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.type,
  });

  int id;
  String originalTitle;
  String posterPath;
  double voteAverage;
  String releaseDate;
  String type;

   // Update the type to double or appropriate numeric type

  factory MovieListModel.fromJson(Map<String, dynamic> json, type) => MovieListModel(
        id: json["id"],
        originalTitle: json.containsKey('original_title') ? json["original_title"] : json["original_name"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        releaseDate: json.containsKey('release_date') ? json["release_date"]?? "" : (json["first_air_date"])?? "",
        type: type,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_title": originalTitle,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "release_date": releaseDate,
        'type': type
      };
}

class MovieDetailModel{
    bool adult;
    String backdropPath;
    dynamic belongsToCollection;
    int budget;
    List<Genre> genres;
    String homepage;
    int id;
    String imdbId;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String posterPath;
    List<ProductionCompany> productionCompanies;
    List<ProductionCountry> productionCountries;
    DateTime releaseDate;
    int revenue;
    int runtime;
    List<SpokenLanguage> spokenLanguages;
    String status;
    String tagline;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    MovieDetailModel({
        required this.adult,
        required this.backdropPath,
        required this.belongsToCollection,
        required this.budget,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.imdbId,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.productionCompanies,
        required this.productionCountries,
        required this.releaseDate,
        required this.revenue,
        required this.runtime,
        required this.spokenLanguages,
        required this.status,
        required this.tagline,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory MovieDetailModel.fromJson(Map<String, dynamic> json) => MovieDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

class Genre {
    int id;
    String name;

    Genre({
        required this.id,
        required this.name,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class ProductionCompany {
    int id;
    String logoPath;
    String name;
    String originCountry;

    ProductionCompany({
        required this.id,
        required this.logoPath,
        required this.name,
        required this.originCountry,
    });

    factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"] ?? '',
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}

class ProductionCountry {
    String iso31661;
    String name;

    ProductionCountry({
        required this.iso31661,
        required this.name,
    });

    factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}

class SpokenLanguage {
    String englishName;
    String iso6391;
    String name;

    SpokenLanguage({
        required this.englishName,
        required this.iso6391,
        required this.name,
    });

    factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}

class TvShowDetailModel {
    bool adult;
    String backdropPath;
    List<dynamic> createdBy;
    List<int> episodeRunTime;
    DateTime? firstAirDate;
    List<Genre> genres;
    String homepage;
    int id;
    bool inProduction;
    List<String> languages;
    String name;
    TEpisodeToAir? nextEpisodeToAir;
    List<Network> networks;
    int numberOfEpisodes;
    int numberOfSeasons;
    List<String> originCountry;
    String originalLanguage;
    String originalName;
    String overview;
    double popularity;
    String posterPath;
    List<Network> productionCompanies;
    List<ProductionCountry> productionCountries;
    List<Season> seasons;
    List<SpokenLanguage> spokenLanguages;
    String status;
    String tagline;
    String type;
    double voteAverage;
    int voteCount;

    TvShowDetailModel({
        required this.adult,
        required this.backdropPath,
        required this.createdBy,
        required this.episodeRunTime,
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.inProduction,
        required this.languages,
        required this.name,
        required this.nextEpisodeToAir,
        required this.networks,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.productionCompanies,
        required this.productionCountries,
        required this.seasons,
        required this.spokenLanguages,
        required this.status,
        required this.tagline,
        required this.type,
        required this.voteAverage,
        required this.voteCount,
    });

    factory TvShowDetailModel.fromJson(Map<String, dynamic> json) => TvShowDetailModel(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        createdBy: List<dynamic>.from(json["created_by"].map((x) => x) ?? []),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x) ?? []),
        firstAirDate: (json["first_air_date"] != "") ? DateTime.parse(json["first_air_date"]) : null,
        genres: List<Genre>.from((json["genres"] ?? []).map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        name: json["name"],
        nextEpisodeToAir: (json["next_episode_to_air"] != null) ? TEpisodeToAir.fromJson(json["next_episode_to_air"]) : null,
        networks: List<Network>.from(json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<Network>.from(json["production_companies"].map((x) => Network.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
        seasons: List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy.map((x) => x)),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date": "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate?.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

class TEpisodeToAir {
    int id;
    String name;
    String overview;
    double voteAverage;
    int voteCount;
    DateTime airDate;
    int episodeNumber;
    String episodeType;
    String productionCode;
    int? runtime;
    int seasonNumber;
    int showId;
    dynamic stillPath;

    TEpisodeToAir({
        required this.id,
        required this.name,
        required this.overview,
        required this.voteAverage,
        required this.voteCount,
        required this.airDate,
        required this.episodeNumber,
        required this.episodeType,
        required this.productionCode,
        required this.runtime,
        required this.seasonNumber,
        required this.showId,
        required this.stillPath,
    });

    factory TEpisodeToAir.fromJson(Map<String, dynamic> json) => TEpisodeToAir(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        productionCode: json["production_code"],
        runtime: json["runtime"]?? 0,
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "air_date": "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
    };
}

class Network {
    int id;
    String logoPath;
    String name;
    String originCountry;

    Network({
        required this.id,
        required this.logoPath,
        required this.name,
        required this.originCountry,
    });

    factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"],
        logoPath: json["logo_path"]?? '',
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}

class Season {
    DateTime? airDate;
    int episodeCount;
    int id;
    String name;
    String overview;
    String? posterPath;
    int seasonNumber;
    double voteAverage;

    Season({
        required this.airDate,
        required this.episodeCount,
        required this.id,
        required this.name,
        required this.overview,
        required this.posterPath,
        required this.seasonNumber,
        required this.voteAverage,
    });

    factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: (json["air_date"] != null) ? DateTime.parse(json["air_date"]) : null,
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "air_date": "${airDate?.year.toString().padLeft(4, '0')}-${airDate?.month.toString().padLeft(2, '0')}-${airDate?.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
    };
}

