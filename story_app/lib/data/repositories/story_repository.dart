import 'package:story_app/data/datasources/story/upload/upload_story_remote_data_source.dart';
import 'package:story_app/data/models/story/detail_story_response.dart';
import 'package:story_app/data/models/story/list_story_response.dart';
import 'package:story_app/data/models/story/upload_story_request_model.dart';

import '../datasources/story/detail/detail_story_remote_data_source.dart';
import '../datasources/story/list/list_story_remote_data_source.dart';
import '../datasources/story/location/location_story_remote_data_source.dart';
import '../datasources/user/user_local_data_source.dart';
import '../models/story/upload_story_response_model.dart';

class StoryRepository {
  final UserLocalDataSource userLocalDataSource;
  final ListStoryRemoteDataSource listStoryRemoteDataSource;
  final LocationStoryRemoteDataSource locationStoryRemoteDataSource;

  final DetailStoryRemoteDataSource detailStoryRemoteDataSource;
  final UploadStoryRemoteDataSource uploadStoryRemoteDataSource;

  StoryRepository(
      this.userLocalDataSource,
      this.listStoryRemoteDataSource,
      this.detailStoryRemoteDataSource,
      this.uploadStoryRemoteDataSource,
      this.locationStoryRemoteDataSource);

  Future<ListStoryResponse> getAllStories({int page = 1}) async {
    final token = await userLocalDataSource.getToken();
    return listStoryRemoteDataSource.getAllStories(token: token, page: page);
  }

  Future<List<ListStory>> getLocations() async {
    final token = await userLocalDataSource.getToken();
    return locationStoryRemoteDataSource.getLocations(token: token);
  }

  Future<DetailStoryResponse> getDetailStories(String id) async {
    final token = await userLocalDataSource.getToken();
    return detailStoryRemoteDataSource.getDetailStory(token: token, id: id);
  }

  Future<UploadStoryResponseModel> postStory(
      UploadStoryRequestModel uploadStory) async {
    final token = await userLocalDataSource.getToken();
    return uploadStoryRemoteDataSource.uploadStory(token, uploadStory);
  }
}
