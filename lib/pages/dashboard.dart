import 'package:flutter/material.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class DashBoard extends StatefulWidget {
  final token;
  const DashBoard({Key? key, this.token}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late String fullName;
  @override
  void initState() {
    super.initState();

    var decodedToken = JwtDecoder.decode(widget.token);// this is to get user credentials from the backend after he signs in
    
    fullName = decodedToken['fullName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("dashboard"),
          Text(fullName),
        ],
      ),
    );
  }
}
