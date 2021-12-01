import 'package:connectivity/connectivity.dart';

import 'package:http/http.dart';
import 'package:oauth_app/common/constants.dart';
import 'package:oauth_app/http/status.dart';
import 'package:oauth_app/model/count.dart';
import 'package:oauth_app/widgets/text_message.dart';

typedef VoidCallbackParam(var param);

class HttpExecute {
  String endpoint;
  var parameters;
  Count? count;
  bool isRefresh;

  HttpExecute(
      {this.endpoint = "",
      this.parameters,
      this.count,
      this.isRefresh = false});

  post() async {
    return await checkConnectivity(executeMethod, "post");
  }

  get() async {
    return await checkConnectivity(executeMethod, "get");
  }

  checkConnectivity(VoidCallbackParam voidCallbackParam, String type) async {
    var connectivityResul = await Connectivity().checkConnectivity();
    return (connectivityResul == ConnectivityResult.wifi ||
            connectivityResul == ConnectivityResult.mobile)
        ? await voidCallbackParam(type)
        : Status(
            type: connectionDisable,
            statusWidget: const TextMessage(text: "Sin conexión"));
  }

  executeMethod(var type) async {
    Response? response;
    count = await Count().getCount();

    count = (count != null)
        ? (isRefresh)
            ? count
            : await count!.verifyToken()
        : count;
    switch (type) {
      case "post":
        response = await Client().post(uri, headers: header, body: parameters);
        break;
      case "get":
        response = await Client().get(uri, headers: header);
        print("response ${response.body}");
        break;
    }
    return validateResponse(response);
  }

  validateResponse(Response? response) {
    return (response!.statusCode >= 200 && response.statusCode < 300)
        ? response.body
        : Status(
            type: serverError,
            response: response,
            statusWidget: TextMessage(
                text:
                    "Error en el servidor ${response.statusCode.toString()}"));
  }

  get uri {
    return Uri.parse(url + endpoint);
  }

  Map<String, String>? get header {
    return {
      "content-type": "application/x-www-form-urlencoded",
      "Authorization": (count != null) ? authorization : ""
    };
  }

  get authorization {
    return "${count!.tokenType} ${count!.accessToken}";
  }
}
