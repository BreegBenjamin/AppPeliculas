import 'dart:convert';

Actor actorFromJson(String str) => Actor.fromJson(json.decode(str));

String actorToJson(Actor data) => json.encode(data.toJson());

class Cast {
  List<Actor> actores = [];
  Cast.fronmJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((element) {
      final actor = new Actor.fromJson(element);
      actores.add(actor);
    });
  }
}

class Actor {
  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
      };

  factory Actor.fronmJsonList(List<dynamic> jsonList) {
    List<Actor> actores = [];
  }

  String getPicture() {
    if (profilePath == null) {
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN1Bjs2AYrrGAQjaKoVz0Hc1PSd-WGv1MkH8LQXcjZa9U-mrHG3X-CEEvXIBli1VkLn4k&usqp=CAU';
    } else {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }
}
