import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todo_nodebackend/widgets/mycolors.dart';

import '../widgets/widgets.dart';
import 'createTodoPage.dart';

class DashBoard extends StatefulWidget {
  final token;
  const DashBoard({Key? key, this.token}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late String fullName;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();

    var decodedToken = JwtDecoder.decode(widget
        .token); // this is to get user credentials from the backend after he signs in

    fullName = decodedToken['fullName'];
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black54,
            body: Center(child: SpinKitDoubleBounce(color: MyColors().green)))
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            backgroundColor: Colors.black54,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hey,\n$fullName",
                      style: TextStyle(color: MyColors().cream, fontSize: 60),
                    )
                    
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                splashColor: MyColors().orange,
                onPressed: () {
                  nextScreen(context, CreateTodo());
                },
                backgroundColor: MyColors().green,
                child: const Icon(Icons.mode_edit)));
  }
}
