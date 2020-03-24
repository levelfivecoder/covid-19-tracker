import 'dart:convert';
import 'package:covid_19_tracker/helpers/customexception.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';


class RestService {
  final String _baseUrl = "https://coronavirus-tracker-api.herokuapp.com/";

  Future<dynamic> get(String url, bool isExternal) async {
    var responseJson;
    try {
      final response = !isExternal?await http.get(_baseUrl + url) : await http.get(url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
