// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) =>
    HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  bool success;
  String message;
  Data data;

  HomeDataModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<Homecontent> homecontent;
  List<Language> languages;
  List<Provier> proviers;

  Data({
    required this.homecontent,
    required this.languages,
    required this.proviers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        homecontent: List<Homecontent>.from(
            json["homecontent"].map((x) => Homecontent.fromJson(x))),
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        proviers: List<Provier>.from(
            json["proviers"].map((x) => Provier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "homecontent": List<dynamic>.from(homecontent.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
        "proviers": List<dynamic>.from(proviers.map((x) => x.toJson())),
      };
}

class Homecontent {
  int id;
  String name;
  List<Datum> data;

  Homecontent({
    required this.id,
    required this.name,
    required this.data,
  });

  factory Homecontent.fromJson(Map<String, dynamic> json) => Homecontent(
        id: json["id"],
        name: json["name"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  Iso6391 originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Datum({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: iso6391Values.map[json["original_language"]]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": iso6391Values.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum Iso6391 {
  TA,
  TE,
  HI,
  ML,
  KN,
  BN,
  EN,
  JA,
  NO,
  KO,
  RU,
  PA,
  GU,
  OR,
  ES,
  MR,
  IT,
  ZH,
  BHO
}

final iso6391Values = EnumValues({
  "bho": Iso6391.BHO,
  "bn": Iso6391.BN,
  "en": Iso6391.EN,
  "es": Iso6391.ES,
  "gu": Iso6391.GU,
  "hi": Iso6391.HI,
  "it": Iso6391.IT,
  "ja": Iso6391.JA,
  "kn": Iso6391.KN,
  "ko": Iso6391.KO,
  "ml": Iso6391.ML,
  "mr": Iso6391.MR,
  "no": Iso6391.NO,
  "or": Iso6391.OR,
  "pa": Iso6391.PA,
  "ru": Iso6391.RU,
  "ta": Iso6391.TA,
  "te": Iso6391.TE,
  "zh": Iso6391.ZH
});

class Language {
  Iso6391 iso6391;
  String englishName;
  String name;

  Language({
    required this.iso6391,
    required this.englishName,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        iso6391: iso6391Values.map[json["iso_639_1"]]!,
        englishName: json["english_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391Values.reverse[iso6391],
        "english_name": englishName,
        "name": name,
      };
}

class Provier {
  int displayPriority;
  String logoPath;
  String providerName;
  String codeId;
  int providerId;

  Provier({
    required this.displayPriority,
    required this.logoPath,
    required this.providerName,
    required this.codeId,
    required this.providerId,
  });

  factory Provier.fromJson(Map<String, dynamic> json) => Provier(
        displayPriority: json["display_priority"],
        logoPath: json["logo_path"],
        providerName: json["provider_name"],
        codeId: json["code_id"],
        providerId: json["provider_id"],
      );

  Map<String, dynamic> toJson() => {
        "display_priority": displayPriority,
        "logo_path": logoPath,
        "provider_name": providerName,
        "code_id": codeId,
        "provider_id": providerId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
