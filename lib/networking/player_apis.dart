import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'custom_exceptions.dart';

abstract class Api {
  Future<dynamic> getPlayerData(num organisationId);
}

class PlayerApi {
  PlayerApi() {
    _getterBaseUrl =
        "https://www.playerline.org/test/static-endpoint/api/newslist/";
  }

  late var _getterBaseUrl;

  Future<dynamic> apiGetter(String urlEndpoint) async {
    var responseJson;
    print(urlEndpoint);
    try {
      final response = await http.get(
        Uri.parse(urlEndpoint),
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 504:
      case 400:
      case 401:
      case 403:
      case 500:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> getPlayerData(num pageNo) async {
    final response = await apiGetter(_getterBaseUrl + "$pageNo.json");
    return response;
  }
}
