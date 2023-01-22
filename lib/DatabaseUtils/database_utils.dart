import 'package:chat_c7_sun/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/my_user.dart';
import '../models/room.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter<Room>(
          fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
          toFirestore: (room, options) => room.toJson(),
        );
  }

  static CollectionReference<Message> getMessagesCollection(String roomId) {
    return getRoomsCollection()
        .doc(roomId)
        .collection(Message.COLLECTION_NAME)
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJon(),
        );
  }

  static Future<void> addMessageToFirestore(Message message) {
    var docRef = getMessagesCollection(message.roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> readMessagesFromFirestore(
      String roomId) {
    return getMessagesCollection(roomId).orderBy("dateTime").snapshots();
  }

  static Future<void> AddRoomToFirestore(Room room) {
    var collection = getRoomsCollection();
    var docRef = collection.doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> readRoomsFromFirestore() async {
    QuerySnapshot<Room> snapRooms = await getRoomsCollection().get();

    return snapRooms.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> AddUserToFirestore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFirestore(String id) async {
    DocumentSnapshot<MyUser> user = await getUsersCollection().doc(id).get();
    var myUser = user.data();
    return myUser;
  }
}
