import 'dart:convert';
import 'package:http/http.dart';

import '../../res/utils/nothing.dart';
import '../../res/utils/request_type.dart';
import '../../res/utils/request_type_exception.dart';

// ============================= Use For Call API With Method  ============================= //

class NetworkClient {
  // ============================= API Base Url ============================= //
  static const String _baseUrl = "https://mocki.io/v1/";
  final Client _client;

  NetworkClient(this._client);

  Future<Response> request({
    required RequestType requestType,
    required String path,
    dynamic parameter = Nothing,
  }) async {
    switch (requestType) {
      case RequestType.GET:
        final response = await _client.get(
          Uri.parse("$_baseUrl$path"),
          // Uri.parse("https://api.jikan.moe/v3/search/anime?q=naruto"),
          // headers: {
          //   "Content-Type": "application/json",
          //   // HttpHeaders.authorizationHeader: 'Bearer ' + token,
          // },
        );
        return response;
      case RequestType.POST:
        final response = await _client.post(Uri.parse("$_baseUrl/$path"),
            headers: {
              "Content-Type": "application/json",
              // HttpHeaders.authorizationHeader: 'Bearer ' + token,
            },
            body: json.encode(parameter));
        return response;
      case RequestType.DELETE:
        return _client.delete(
          Uri.parse("$_baseUrl/$path"),
          headers: {
            "Content-Type": "application/json",
            // HttpHeaders.authorizationHeader: 'Bearer ' + token,
          },
        );

      case RequestType.PUT:
        final response = await _client.put(Uri.parse("$_baseUrl/$path"),
            headers: {
              "Content-Type": "application/json",
              // HttpHeaders.authorizationHeader: 'Bearer ' + token,
            },
            body: json.encode(parameter));
        return response;
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request mentioned is not found");
    }
  }
}
