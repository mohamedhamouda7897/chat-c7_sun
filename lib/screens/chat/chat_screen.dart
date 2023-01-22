import 'package:chat_c7_sun/base.dart';
import 'package:chat_c7_sun/models/message.dart';
import 'package:chat_c7_sun/models/room.dart';
import 'package:chat_c7_sun/providers/my_provider.dart';
import 'package:chat_c7_sun/screens/chat/chat_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'message_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var provider = Provider.of<MyProvider>(context);
    viewModel.myUser = provider.myUser!;
    viewModel.room = room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/main_bg.png",
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(room.title),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 48),
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
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.getMessages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("something went wrong");
                      }
                      var messages =
                          snapshot.data?.docs.map((e) => e.data()).toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MessageWidget(messages![index]);
                        },
                        itemCount: messages?.length ?? 0,
                      );
                    },
                  )),
                  Container(
                    padding: EdgeInsets.only(bottom: 6, left: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                                hintText: "Type a message",
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(color: Colors.blue)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                    ),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.sendMessage(messageController.text);
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Text(
                                  "Send",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void uploadMessageToFirestore() {
    messageController.clear();
    setState(() {});
  }

  @override
  ChatViewModel initViewModel() => ChatViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }
}
