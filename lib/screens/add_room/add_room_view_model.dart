import 'package:chat_c7_sun/DatabaseUtils/database_utils.dart';
import 'package:chat_c7_sun/base.dart';
import 'package:chat_c7_sun/models/room.dart';
import 'package:chat_c7_sun/screens/add_room/add_room_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void AddRoomToDB(String title, String desc, String catId) {
    Room room = Room(title: title, desc: desc, catId: catId);

    DatabaseUtils.AddRoomToFirestore(room).then((value) {
      navigator!.roomCreated();
    }).catchError((error) {});
  }
}
