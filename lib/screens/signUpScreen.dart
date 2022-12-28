import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hive_login/db/db_functions.dart';
import 'package:hive_login/models/user_model.dart';
import 'package:hive_login/screens/loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();
  final TextEditingController conformpassword_controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      controller: conformpassword_controller,
                      decoration:
                          InputDecoration(hintText: "conform your password"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          validateSignUp();
                        },
                        child: Text("Submit")),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "already a user ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "login !",
                            ))
                      ],
                    )
                  ],
                ),
              )
            ]),
      )),
    );
  }

  void validateSignUp() async {
    final email = email_controller.text.trim();
    final password = password_controller.text.trim();
    final conformpassword = conformpassword_controller.text.trim();
    final isEmailValidated = EmailValidator.validate(email);
    if (email != '' && password != '' && conformpassword != '') {
      if (isEmailValidated == true) {
        final ispasswordValidated = checkPassword(password, conformpassword);
        if (ispasswordValidated == true) {
          final user = UserModel(email: email, password: password);
          await DBFunction.instance.userSignUp(user);
          Get.back();
          Get.snackbar("sucess", "Account created");
          print('sucess');
        }
      } else {
        Get.snackbar("error", "please provide a valid email");
      }
    } else {
      Get.snackbar("error", "field cannot be empty");
    }
  }

  bool checkPassword(String pass, String conPass) {
    if (pass == conPass) {
      if (pass.length < 6) {
        Get.snackbar("error", "Password must contain 6 charaters or more");
        return false;
      } else {
        return true;
      }
    } else {
      Get.snackbar(
          "password mismatch", "password and conform password are not same");
      return false;
    }
  }
}
