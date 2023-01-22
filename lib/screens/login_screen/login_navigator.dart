import 'package:chat_c7_sun/base.dart';
import 'package:chat_c7_sun/models/my_user.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome(MyUser myUser);
}
