import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hive_login/db/db_functions.dart';
import 'package:hive_login/models/user_model.dart';
import 'package:hive_login/screens/Homescreen.dart';
import 'package:hive_login/screens/signUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Center(
            child: Container(
          // width: MediaQuery.of(context).size.width / 2,
          width: 300,
          height: 450,
          color: Colors.grey[200],
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.black, fontSize: 21),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: email_controller,
                        decoration: InputDecoration(hintText: "enter email"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        obscureText: true,
                        controller: password_controller,
                        decoration: InputDecoration(hintText: "enter password"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final list = await DBFunction.instance.getUser();
                            checkUser(list);
                          },
                          child: Text("Submit")),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "new user ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => SignUpScreen());
                              },
                              child: Text(
                                "register here",
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ]),
        )),
      ),
    );
  }

  Future<void> checkUser(List<UserModel> userList) async {
    final email = email_controller.text.trim();
    final password = password_controller.text.trim();
    bool isUserFound = false;
    final isValidated = await validateLogin(email, password);
    if (isValidated == true) {
      await Future.forEach(userList, (user) {
        if (user.email == email && user.password == password) {
          isUserFound = true;
        } else {
          isUserFound = false;
        }
      });
      if (isUserFound == true) {
        Get.offAll(() => HomeScreen(email: email));
        Get.snackbar("sucess", 'Logged in As $email');
      } else {
        Get.snackbar("Error", "incorrect email or password");
      }
    } else {
      Get.snackbar("Error", "Fields cannot be empty");
    }
  }

  Future<bool> validateLogin(String email, String password) async {
    if (email != "" && password != "") {
      return true;
    } else {
      return false;
    }
  }
}
