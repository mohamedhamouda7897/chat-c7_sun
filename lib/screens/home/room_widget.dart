import 'package:chat_c7_sun/models/room.dart';
import 'package:chat_c7_sun/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator to chat screen
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: room);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/images/${room.catId}.jpeg",
                    width: MediaQuery.of(context).size.width * .30,
                    fit: BoxFit.fitWidth,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(room.title)
            ],
          ),
        ),
      ),
    );
  }
}
