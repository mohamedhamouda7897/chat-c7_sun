import 'package:chat_c7_sun/DatabaseUtils/database_utils.dart';
import 'package:chat_c7_sun/models/my_user.dart';
import 'package:chat_c7_sun/shared/constants/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../base.dart';
import 'create_account_navigator.dart';

class CreateAccountViewModel extends BaseViewModel<CreateAccountNavigator> {
  String message = "";
  var auth = FirebaseAuth.instance;

  void CreateAccountWithFirebaseAuth(
      String email, String password, String firstName, String userName) async {
    try {
      navigator!.showLoading();
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = "Account Created";
      // Add Data to Database
      MyUser myUser = MyUser(
          id: credential.user?.uid ?? "",
          fName: firstName,
          userName: userName,
          email: email);
      DatabaseUtils.AddUserToFirestore(myUser).then((value) {
        // Go To Home />> Login
        navigator!.hideDialog();
        navigator!.goToHome(myUser);
        return;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        message = "The password provided is too weak.";
      } else if (e.code == FirebaseErrors.emailInUse) {
        message = "This account already exists for that email..";
      }
    } catch (e) {
      message = "Something went wrong $e";
    }

    if (message != "") {
      navigator!.hideDialog();
      navigator!.showMessage(message);
    }
  }
}
