// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_nodebackend/pages/dashboard.dart';
import 'package:todo_nodebackend/widgets/mycolors.dart';
import 'package:todo_nodebackend/widgets/widgets.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black54,
            body: Center(child: SpinKitDoubleBounce(color: MyColors().green)))
        : Scaffold(
            backgroundColor: Colors.black54,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: title,
                    style: TextStyle(
                      color: Colors.white, // Set the desired text color
                    ),
                    decoration: textInputDecoration.copyWith(
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      prefixIcon: Icon(Icons.title, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    height: 200.0,
                    child: TextField(
                      controller: description,
                      style: TextStyle(
                        color: Colors.white60, // Set the desired text color
                      ),
                      maxLines:
                          null, // Allows the input field to expand vertically as needed
                      decoration: InputDecoration(
                        hintText: "description...",
                        hintStyle: TextStyle(color: Colors.white),

                        fillColor: Colors.white,

                        border: InputBorder
                            .none, // Remove the default input field border
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: MyColors().green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // Perform action with title and description values
                      nextScreenReplace(context, DashBoard());
                    },
                  ),
                ],
              ),
            ),

            // Text(fullName),
          );
  }
}
