import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:todo_nodebackend/widgets/constants.dart';

class ServiceFunctions {
  registerUserInDatabase(email, password, fullName) async {
    var reqBody = {'email': email, 'password': password, 'fullName': fullName};
    var response = await https.post(
      Uri.parse(registration),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    print(response.body);
    
    return response;
  }

  loginUser(email, password) async {
    var reqBody = {
      'email': email,
      'password': password,
    };
    var res = await https.post(
      Uri.parse(login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    print(res.body);
    return res;
  }
}
