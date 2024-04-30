import 'dart:math';

import 'package:dio/dio.dart';
import 'package:story_app/data/models/story/list_story_response.dart';
import 'package:story_app/utils/constant/validation.dart';

import '../../../../utils/base_url.dart';

class LocationStoryRemoteDataSource {
  static Dio dio = Dio();

  Future<List<ListStory>> getLocations({
    int page = 1,
    int size = 20,
    int location = 1,
    required String token,
  }) async {
    try {
      final response = await dio.get(
        '${BaseUrl.baseUrl}/stories',
        queryParameters: {
          'page': page,
          'size': size,
          'location': location,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> storyList = response.data['listStory'];
        final List<ListStory> parsedStoryList =
            storyList.map((json) => ListStory.fromJson(json)).toList();
        print(response.data);
        return parsedStoryList;
      } else {
        throw Exception('Failed to load stories: ${response.statusCode}');
      }
    } catch (e) {
     Validation.handleError(e);
    }
    return Future.error(e);
  }
}
