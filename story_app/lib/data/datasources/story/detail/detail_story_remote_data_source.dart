import 'package:dio/dio.dart';

import '../../../../utils/base_url.dart';
import '../../../models/story/detail_story_response.dart';

class DetailStoryRemoteDataSource {
  static Dio dio = Dio();

  Future<DetailStory> getDetailStory({required String token, required String id}) async {
    try {
      final response = await dio.get(
        '${BaseUrl.baseUrl}/stories/$id',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final dynamic storyData = response.data['story'];
        final DetailStory detailStory = DetailStory.fromJson(storyData);
        return detailStory;
      } else {
        throw Exception('Failed to load detail story: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load detail story: $e');
    }
  }
}
