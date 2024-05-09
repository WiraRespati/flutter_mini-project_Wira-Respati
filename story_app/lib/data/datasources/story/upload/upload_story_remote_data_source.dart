
import 'package:dio/dio.dart';
import 'package:story_app/data/models/story/upload_story_request_model.dart';
import 'package:story_app/data/models/story/upload_story_response_model.dart';
import 'package:story_app/utils/constant/validation.dart';

import '../../../../utils/base_url.dart';

class UploadStoryRemoteDataSource {
  static Dio dio = Dio();

  Future<UploadStoryResponseModel> uploadStory(
      String token, UploadStoryRequestModel uploadStory) async {
    final url = '${BaseUrl.baseUrl}/stories'; // Update the URL to /stories
    try {
      final formData = FormData.fromMap({
        'description': uploadStory.description,
        'photo': await MultipartFile.fromFile(uploadStory.photo.path,
            filename: 'photo.jpg'), // Assuming the photo is a File object
        'lat': uploadStory.lat,
        'lon': uploadStory.lon,
      });

      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          contentType: 'multipart/form-data',
        ),
      );

      final uploadStoryResponse =
          UploadStoryResponseModel.fromJson(response.data);
      return uploadStoryResponse;
    } catch (e) {
      Validation.handleError(e);
      return Future.error(e);
    }
  }
  
}
