class RoomCategory {
  static String sportsId = "sports";
  static String musicId = "music";
  static String moviesId = "movies";

  String id;
  late String name;
  late String image;

  RoomCategory(this.id, this.name, this.image);

  RoomCategory.fromId(this.id) {
    name = id;
    image = "assets/images/$id.jpeg";
  }

  static List<RoomCategory> getCategories() {
    return [
      RoomCategory.fromId(sportsId),
      RoomCategory.fromId(musicId),
      RoomCategory.fromId(moviesId),
    ];
  }
}
