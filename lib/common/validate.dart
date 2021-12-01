import 'dart:convert';

import 'package:http/http.dart';
import 'package:oauth_app/http/http_execute.dart';
import 'package:oauth_app/http/status.dart';
import 'package:oauth_app/model/count.dart';
import 'package:oauth_app/model/user.dart';

class Validate {
  var data;
  Validate(this.data);

  checkKeyExists({String key = "", var initialize}) {
    return (data.containsKey(key) && data[key] != null)
        ? data[key]
        : initialize;
  }

  checkIsStatusOrResponse(VoidCallbackParam method) {
    return (data is Status) ? data : method(json.decode(data));
  }

  static bool isNotStatus(data) {
    return (data != null && data is! Status);
  }

  static isWrongEmailPassword(Response? response) {
    return response!.statusCode ==
        403; // error en la autenticacion y no inesperado del server
  }

  static deleteUserAndCount(Count? count, User? user) async {
    if (count != null) {
      if (await count.delete(count.id) && user != null) {
        if (await user.delete(user.id)) {
          count = null;
          user = null;
        }
      }
    }
    return (count == null && user == null);
  }
}
