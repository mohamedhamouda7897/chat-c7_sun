import 'package:chat_c7_sun/models/my_user.dart';
import 'package:chat_c7_sun/screens/create_account/create_account_navigator.dart';
import 'package:chat_c7_sun/screens/create_account/create_account_view_model.dart';
import 'package:chat_c7_sun/screens/home/home.dart';
import 'package:chat_c7_sun/screens/login_screen/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base.dart';
import '../../providers/my_provider.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = "CreateAccount";

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState
    extends BaseView<CreateAccountScreen, CreateAccountViewModel>
    implements CreateAccountNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fNameController = TextEditingController();
  var userNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text('Create Account'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: fNameController,
                      validator: (value) {
                        if (value?.trim() == "") {
                          return "Please enter first name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "First Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: userNameController,
                      validator: (value) {
                        if (value?.trim() == "") {
                          return "Please enter UserName";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "UserName",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter email";
                        } //fsdjfdsfhsdkj
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (emailValid == false) {
                          return "Please enter valid email";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value?.trim() == "") {
                          return "Please enter password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ValidateForm();
                        },
                        child: Text('Create Account')),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text("I Have an Account"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ValidateForm() async {
    if (formKey.currentState!.validate()) {
      viewModel.CreateAccountWithFirebaseAuth(
          emailController.text,
          passwordController.text,
          fNameController.text,
          userNameController.text);
    }
  }

  @override
  CreateAccountViewModel initViewModel() {
    return CreateAccountViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    // go to home screen
    Provider.of<MyProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
