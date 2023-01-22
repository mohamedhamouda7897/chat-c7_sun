import 'package:chat_c7_sun/DatabaseUtils/database_utils.dart';
import 'package:chat_c7_sun/base.dart';
import 'package:chat_c7_sun/models/my_user.dart';
import 'package:chat_c7_sun/screens/login_screen/login_navigator.dart';
import 'package:chat_c7_sun/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/constants/firebase_errors.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;
  String message = "";

  void loginWithFirebaseAuth(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = "Successfully logged";
      // Read User from Database
      MyUser? myUser =
          await DatabaseUtils.readUserFromFirestore(credential.user?.uid ?? "");
      if (myUser != null) {
        //Go To Home
        navigator!.hideDialog();
        navigator!.goToHome(myUser);
        return;
      }
    } on FirebaseAuthException catch (e) {
      message = "wrong email or password";
    } catch (e) {
      message = "Something went wrong $e";
    }

    if (message != "") {
      navigator!.hideDialog();
      navigator!.showMessage(message);
    }
  }
}
