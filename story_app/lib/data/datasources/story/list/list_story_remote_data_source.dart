
import 'package:dio/dio.dart';
import 'package:story_app/data/models/story/list_story_response.dart';

import '../../../../utils/base_url.dart';
import '../../../../utils/constant/validation.dart';

class ListStoryRemoteDataSource {
  static Dio dio = Dio();

  Future<ListStoryResponse> getAllStories({
    int page = 1,
    int size = 20,
    required String token,
  }) async {
    try {
      final response = await dio.get(
        '${BaseUrl.baseUrl}/stories',
        queryParameters: {
          'page': page,
          'size': size,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final list = ListStoryResponse.fromJson(response.data);
        return list;
      } else {
        throw Exception('Failed to load stories: ${response.statusCode}');
      }
    } catch (e) {
     Validation.handleError(e);
      return Future.error(e);
    }
   
  }
}
