// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_nodebackend/pages/dashboard.dart';
import 'package:todo_nodebackend/widgets/mycolors.dart';
import 'package:todo_nodebackend/widgets/widgets.dart';

import '../services/serviceFunctions.dart';
import 'registerpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email = "";
  String password = "";

  late SharedPreferences sharedPrefs; // initialized shared  prefrences

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      var response = await ServiceFunctions().loginUser(email, password);

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        showsnackbar(
            context: context,
            message: "User Logged Successfully",
            color: Colors.green);
      }
      var jsonResponse = jsonDecode(response.body);
      var token = jsonResponse[
          'token']; // token is received from the backend in form of response and it has the user credentials
      sharedPrefs.setString('token',
          token); // it can be used to initialize shared prefrences it is stored in the token in our gift
      nextScreenReplace(context, DashBoard(token: token));
    } else {
      setState(() {
        _isLoading = false;
        showsnackbar(
            context: context,
            message: "Please Enter proper values",
            color: Colors.red);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black54,
            body: Center(child: SpinKitDoubleBounce(color: MyColors().green)))
        : Scaffold(
            backgroundColor: Colors.black54,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 60),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "TO",
                                style: TextStyle(
                                    color: MyColors().yellow,
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 17.0),
                                child: Text(
                                  "day",
                                  style: TextStyle(
                                      color: MyColors().green,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "DO",
                                      style: TextStyle(
                                          color: MyColors().orange,
                                          fontSize: 90,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        " it",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: MyColors().blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Image.asset(
                                "assets/logo.png",
                                width: 175,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        style: TextStyle(color: MyColors().cream),
                        cursorColor: MyColors().blue,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email_outlined,
                                color: Colors.white)),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please enter a valid email";
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: TextStyle(color: MyColors().cream),
                        cursorColor: MyColors().blue,
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.email_outlined,
                                color: Colors.white)),
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Passwod must be atleast 6 characters";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 35),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            loginUser();
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: MyColors().green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text.rich(TextSpan(
                        text: "Dont have an account? ",
                        style: TextStyle(color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Register here",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, RegisterPage());
                                })
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
