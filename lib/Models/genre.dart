class Genre{
  String name;
  String iconUrl;

  Genre(this.name,this.iconUrl);

  factory Genre.fromJson(Map<String, dynamic> json){
    return Genre(
      json['name'],
      json["icon_url"],
    );
  }
}

class Genres{
  List<Genre> genres;

  Genres(this.genres);

  factory Genres.fromJson(Map<String, dynamic> json){
    List<dynamic> genreMaps = json["genres"];
    List<Genre> genreList;
    genreList = genreMaps.map((genre) {
      return Genre(genre["name"]!, genre["icon_url"]!);
    }).toList();
    return Genres(genreList);

  }

}