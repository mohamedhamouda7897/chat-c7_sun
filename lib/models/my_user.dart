import 'dart:convert';

class MyUser {
  static const String COLLECTION_NAME = "Users";
  String id;
  String fName;
  String userName;
  String email;

  MyUser(
      {required this.id,
      required this.fName,
      required this.userName,
      required this.email});

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          fName: json["fName"],
          userName: json["userName"],
          email: json["email"],
        );

  Map<String, dynamic> toJson() {
    return {"id": id, "fName": fName, "userName": userName, "email": email};
  }
}
