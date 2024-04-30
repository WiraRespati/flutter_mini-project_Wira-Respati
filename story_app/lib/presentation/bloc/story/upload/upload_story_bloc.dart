import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/bloc/story/upload/upload_story_event.dart';
import 'package:story_app/presentation/bloc/story/upload/upload_story_state.dart';

import '../../../../data/repositories/story_repository.dart';


class UploadStoryBloc extends Bloc<UploadStoryEvent, UploadStoryState> {
  final StoryRepository storyRepository;

  UploadStoryBloc(this.storyRepository) : super(UploadStoryInitial()) {
    on<UploadStoryButtonPressed>(_onUploadStoryButtonPressed);
  }

  void _onUploadStoryButtonPressed(
      UploadStoryButtonPressed event, Emitter<UploadStoryState> emit) async {
    emit(UploadStoryLoading());
    try {
      await storyRepository.postStory(event.uploadModel);
      emit(UploadStorySuccess());
    } catch (error) {
      emit(UploadStoryFailure(error: error.toString()));
    }
  }
}
