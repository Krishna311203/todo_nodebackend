import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_nodebackend/pages/dashboard.dart';
import 'package:todo_nodebackend/pages/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: sharedPreferences.getString(
        'token'), // this is accessed from the shared prefrences which we stored in the login page
  ));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({Key? key, this.token}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'lufga'),
      home: (JwtDecoder.isExpired(token) == false)
          ? DashBoard(token: token)
          : LoginPage(),
    );
  }
}
