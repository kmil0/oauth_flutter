import 'package:oauth_app/common/validate.dart';
import 'package:oauth_app/database/crud.dart';
import 'package:oauth_app/database/tables.dart';
import 'package:oauth_app/http/endpoints.dart';

class Count extends CRUD {
  int id;
  String refreshToken;
  String accessToken;
  String createdAt;
  String expireIn;
  String expireTime;
  String tokenType;
  Count(
      {this.id = 0,
      this.refreshToken = '',
      this.accessToken = '',
      this.createdAt = '',
      this.expireIn = '',
      this.expireTime = '',
      this.tokenType = ''})
      : super(Tables.count);

  factory Count.toObject(Map<String, Object?> data) {
    Validate validate = Validate(data);
    return Count(
        id: validate.checkKeyExists(key: "id", initialize: 0),
        accessToken:
            validate.checkKeyExists(key: "access_token", initialize: ""),
        refreshToken:
            validate.checkKeyExists(key: "refresh_token", initialize: ""),
        createdAt: validate.checkKeyExists(key: "created_at", initialize: ""),
        expireIn: validate
            .checkKeyExists(key: "expires_in", initialize: "")
            .toString(),
        expireTime: validate.checkKeyExists(key: "expire_time", initialize: ""),
        tokenType: validate.checkKeyExists(key: "token_type", initialize: ""));
  }

  Map<String, dynamic> toMap() {
    return {
      "access_token": this.accessToken,
      "refresh_token": this.refreshToken,
      "created_at": this.createdAt,
      "expires_in": this.expireIn,
      "expire_time": this.expireTime,
      "token_type": this.tokenType
    };
  }

  login(String email, String password) async {
    var data = await EndPoints.login(email, password);
    print("Respuesta: $data");
    return Validate(data).checkIsStatusOrResponse(saveOrUpdate);
  }

  saveOrUpdate(data) async {
    Count count = addExpireTime(Count.toObject(data));
    count.id = (count.id > 0)
        ? await update(count.toMap())
        : await insert(count.toMap());
    return count;
  }

  getCount() async {
    List<Map<String, Object?>> result =
        await query("SELECT * FROM ${Tables.count}");
    return (result.isNotEmpty) ? Count.toObject(result[0]) : null;
  }

  addExpireTime(Count count) {
    var time = DateTime.now();
    count.expireTime =
        time.add(Duration(seconds: int.parse(count.expireIn))).toString();
    count.createdAt = time.toString();
    return count;
  }

  Future<Count> verifyToken() async {
    Count count = this;
    if (isInvalidAccessToken()) {
      var refreshCount = await refreshAccessToken();
      if (Validate.isNotStatus(refreshCount)) count = refreshCount;
    }
    return count;
  }

  refreshAccessToken() async {
    var data = await EndPoints.refreshAccessToken(refreshToken);
    return Validate(data).checkIsStatusOrResponse(saveOrUpdate);
  }

  bool isInvalidAccessToken() {
    return DateTime.now().isAfter(DateTime.parse(expireTime));
  }
}
