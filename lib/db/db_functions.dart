import 'package:hive/hive.dart';
import 'package:hive_login/models/user_model.dart';

class DBFunction {
  DBFunction._internal();
  static DBFunction instance = DBFunction._internal();
  factory DBFunction() {
    return instance;
  }
  //----add user----
  Future<void> userSignUp(UserModel user) async {
    final db = await Hive.openBox<UserModel>('user');
    db.put(user.id, user);
  }

  //-----------get user-------
  Future<List<UserModel>> getUser() async {
    final db = await Hive.openBox<UserModel>('user');
    return db.values.toList();
  }
}
