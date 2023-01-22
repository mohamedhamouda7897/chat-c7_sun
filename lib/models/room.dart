class Room {
  static const String COLLECTION_NAME = "Rooms";
  String id;
  String title;
  String desc;
  String catId;

  Room(
      {this.id = "",
      required this.title,
      required this.desc,
      required this.catId});

  Room.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          desc: json["desc"],
          catId: json["catId"],
        );

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "desc": desc, "catId": catId};
  }
}
