import 'dart:convert';

import 'package:http/http.dart' as http;

import '../res/Home/model/home_model.dart';
import '../res/utils/request_type.dart';
import 'network/network.dart';

// ============================= Use For All Api Services   ============================= //

class HomeDataService {
  final client = NetworkClient(http.Client());

  Future getHomePageResult({required int page}) async {
    final response = await client.request(
      requestType: RequestType.GET,
      path: '7216c139-1728-4ab4-b0b0-704a98687acf',
    );

    List<Results> allResults = [];

    List resultss = json.decode(response.body)['results'] as List;

    for (final result in resultss) {
      Results results = Results(
          imageUrl: result['imageUrl'],
          title: result['title'],
          body: result['body']

      );
      allResults.add(results);
    }
    return HomeResultModel(
        results: allResults,
    /*    lastPage: json.decode(response.body)['last_page'],
        requestHash: json.decode(response.body)['request_hash'],
        requestCached: json.decode(response.body)['request_cached'],
        requestCacheExpiry: json.decode(response.body)['request_cache_expiry']*/);
  }
}
