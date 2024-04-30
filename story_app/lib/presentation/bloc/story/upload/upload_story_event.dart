import 'package:equatable/equatable.dart';

import '../../../../data/models/story/upload_story_request_model.dart';

abstract class UploadStoryEvent extends Equatable {
  const UploadStoryEvent();

  @override
  List<Object?> get props => [];
}

class UploadStoryButtonPressed extends UploadStoryEvent {
  final UploadStoryRequestModel uploadModel;

  const UploadStoryButtonPressed(this.uploadModel);

  @override
  List<Object?> get props => [uploadModel];
}
