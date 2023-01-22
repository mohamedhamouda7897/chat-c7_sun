import 'package:chat_c7_sun/base.dart';
import 'package:chat_c7_sun/models/category.dart';
import 'package:chat_c7_sun/screens/add_room/add_room_navigator.dart';
import 'package:chat_c7_sun/screens/add_room/add_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "add-room";

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var categories = RoomCategory.getCategories();
  late RoomCategory selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    selectedCategory = categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Stack(children: [
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
              title: Text('Add Room'),
            ),
            body: SingleChildScrollView(
              child: Card(
                elevation: 22,
                margin: EdgeInsets.all(30),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent)),
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 18),
                    child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Create New Room",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Image.asset("assets/images/create_room_bg.png"),
                              TextFormField(
                                controller: titleController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value?.trim() == "") {
                                    return "Please enter room title";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Title",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButton<RoomCategory>(
                                value: selectedCategory,
                                items: categories
                                    .map(
                                        (cat) => DropdownMenuItem<RoomCategory>(
                                            value: cat,
                                            child: Row(
                                              children: [
                                                Image.asset(cat.image),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(cat.name)
                                              ],
                                            )))
                                    .toList(),
                                onChanged: (category) {
                                  if (category == null) {
                                    return;
                                  } else {
                                    selectedCategory = category;
                                  }
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: descriptionController,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value?.trim() == "") {
                                    return "Please enter Room Description";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Description",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    ValidateForm();
                                  },
                                  child: Text('Create Room')),
                            ]))),
              ),
            ),
          )
        ]));
  }

  void ValidateForm() {
    if (formKey.currentState!.validate()) {
      // Create Room
      viewModel.AddRoomToDB(titleController.text, descriptionController.text,
          selectedCategory.id);
    }
  }

  @override
  void roomCreated() {
    // TODO: implement roomCreated
    Navigator.pop(context);
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }
}
