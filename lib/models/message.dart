class Message {
  static String COLLECTION_NAME = "Messages";
  String id;
  String content;
  int dateTime;
  String roomId;
  String senderId;
  String senderName;

  Message(
      {this.id = "",
      required this.content,
      required this.dateTime,
      required this.roomId,
      required this.senderId,
      required this.senderName});

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          content: json['content'],
          dateTime: json['dateTime'],
          roomId: json['roomId'],
          senderId: json['senderId'],
          senderName: json['senderName'],
        );

  Map<String, dynamic> toJon() {
    return {
      "id": id,
      "content": content,
      "dateTime": dateTime,
      "roomId": roomId,
      "senderId": senderId,
      "senderName": senderName,
    };
  }
}
