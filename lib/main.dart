import 'package:chat_c7_sun/providers/my_provider.dart';
import 'package:chat_c7_sun/screens/add_room/add_room_screen.dart';
import 'package:chat_c7_sun/screens/chat/chat_screen.dart';
import 'package:chat_c7_sun/screens/create_account/create_account.dart';
import 'package:chat_c7_sun/screens/home/home.dart';
import 'package:chat_c7_sun/screens/login_screen/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser != null
          ? HomeScreen.routeName
          : LoginScreen.routeName,
      routes: {
        CreateAccountScreen.routeName: (context) => CreateAccountScreen(),
        LoginScreen.routeName: (c) => LoginScreen(),
        HomeScreen.routeName: (c) => HomeScreen(),
        ChatScreen.routeName: (c) => ChatScreen(),
        AddRoomScreen.routeName: (c) => AddRoomScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
