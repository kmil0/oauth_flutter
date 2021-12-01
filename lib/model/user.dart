import 'package:oauth_app/common/validate.dart';
import 'package:oauth_app/database/crud.dart';
import 'package:oauth_app/database/tables.dart';
import 'package:oauth_app/http/endPoints.dart';
import 'package:oauth_app/model/count.dart';

class User extends CRUD {
  int id;
  String userName;
  String name;
  String email;

  User({
    this.id = 0,
    this.userName = '',
    this.name = '',
    this.email = '',
  }) : super(Tables.user);

  factory User.toObject(Map<String, Object?> data) {
    Validate validate = Validate(data);
    return User(
      id: validate.checkKeyExists(key: "id", initialize: 0),
      userName: validate.checkKeyExists(key: "username", initialize: ""),
      name: validate.checkKeyExists(key: "name", initialize: ""),
      email: validate.checkKeyExists(key: "email", initialize: ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {"username": userName, "name": name, "email": email};
  }

  getUserServer() async {
    var data = await EndPoints.getUser();
    print("Respuesta: $data");
    return Validate(data).checkIsStatusOrResponse(saveOrUpdate);
  }

  saveOrUpdate(data) async {
    User user = User.toObject(data);
    user.id =
        (user.id > 0) ? await update(user.toMap()) : await insert(user.toMap());
    return user;
  }

  Future<User?> getUser() async {
    List<Map<String, Object?>> result =
        await query("SELECT * FROM ${Tables.user}");
    return (result.isNotEmpty) ? User.toObject(result[0]) : null;
  }
}
