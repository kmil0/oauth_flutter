import 'package:oauth_app/common/constants.dart';
import 'package:oauth_app/http/http_execute.dart';

class EndPoints {
  static login(String email, String passwor) {
    Map parameters = {
      grantType: "password",
      userName: email,
      password: passwor,
      audience: url + api, //API para realizar peticiones
      scope: "offline_access openid",
      clientID: appId,
      clientSecret: appSecret
    };

    return HttpExecute(endpoint: "/oauth/token", parameters: parameters).post();
  }

  static getUser() {
    return HttpExecute(endpoint: "/userinfo").get();
  }

  static refreshAccessToken(String refreshToken) {
    Map parameters = {
      grantType: "refresh_token",
      "refresh_token": refreshToken,
      clientID: appId,
      clientSecret: appSecret
    };
    return HttpExecute(
            endpoint: "/oauth/token", parameters: parameters, isRefresh: true)
        .post();
  }
}
