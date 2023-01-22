import 'package:chat_c7_sun/DatabaseUtils/database_utils.dart';
import 'package:chat_c7_sun/base.dart';

import '../../models/room.dart';

class HomeViewModel extends BaseViewModel {
  List<Room> rooms = [];

  void readRooms() {
    DatabaseUtils.readRoomsFromFirestore().then((value) {
      rooms = value;
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }
}
