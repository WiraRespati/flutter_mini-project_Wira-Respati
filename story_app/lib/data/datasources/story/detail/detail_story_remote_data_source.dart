import 'package:dio/dio.dart';

import '../../../../utils/base_url.dart';
import '../../../models/story/detail_story_response.dart';

class DetailStoryRemoteDataSource {
  static Dio _dio = Dio();

  Future<DetailStoryResponse> getDetailStory({required String token, required String id}) async {
    try {
      final response = await _dio.get(
        '${BaseUrl.baseUrl}/stories/$id',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final detail = DetailStoryResponse.fromJson(response.data);
        print("status: ${response.statusMessage}");
        return detail;
      } else {
        throw Exception('Failed to load detail story: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to load detail story: $e');
    }
  }
}
