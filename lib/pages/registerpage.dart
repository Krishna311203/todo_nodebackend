// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:todo_nodebackend/services/serviceFunctions.dart';
import '../../../widgets/widgets.dart';
import 'loginpage.dart';
import '../widgets/mycolors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";

  registerUserButton() async {
    if (email.isNotEmpty && password.isNotEmpty && fullName.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      var response = await ServiceFunctions()
          .registerUserInDatabase(email, password, fullName);
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        showsnackbar(
            context: context,
            message: "User registered Successfully",
            color: Colors.green);
        nextScreenReplace(context, LoginPage());
      }
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
    return _isLoading
        ? Scaffold(
            body: Center(child: SpinKitDoubleBounce(color: MyColors().green)))
        : Scaffold(
            backgroundColor: Colors.black,
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
                          SizedBox(height: 40),
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
                      TextFormField(
                        style: TextStyle(color: MyColors().cream),
                        cursorColor: MyColors().blue,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.person_outline,
                                color: Colors.white)),
                        onChanged: (val) {
                          setState(() {
                            fullName = val;
                          });
                        },
                        validator: (val) {
                          return val!.isNotEmpty
                              ? null
                              : "Name cannot be empty";
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: TextStyle(color: MyColors().cream),
                        cursorColor: MyColors().blue,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            )),
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
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            )),
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password must be at least 6 characters";
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
                      SizedBox(height: 15),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            registerUserButton();
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: MyColors().green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text.rich(TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Login now",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, LoginPage());
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
