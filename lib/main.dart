import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_login/models/user_model.dart';
import 'package:hive_login/screens/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('user');
  runApp(GetMaterialApp(
    theme: ThemeData(
        backgroundColor: Colors.blue.shade300,
        scaffoldBackgroundColor: Colors.blue.shade300),
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
