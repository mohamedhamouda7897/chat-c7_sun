import 'package:chat_c7_sun/DatabaseUtils/database_utils.dart';
import 'package:chat_c7_sun/base.dart';
import 'package:chat_c7_sun/models/message.dart';
import 'package:chat_c7_sun/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/my_user.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  late MyUser myUser;

  void sendMessage(String content) {
    Message message = Message(
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        roomId: room.id,
        senderId: myUser.id,
        senderName: myUser.userName);
    DatabaseUtils.addMessageToFirestore(message).then((value) {
      navigator!.uploadMessageToFirestore();
    });
  }

  Stream<QuerySnapshot<Message>> getMessages() {
    return DatabaseUtils.readMessagesFromFirestore(room.id);
  }
}

abstract class ChatNavigator extends BaseNavigator {
  void uploadMessageToFirestore();
}
