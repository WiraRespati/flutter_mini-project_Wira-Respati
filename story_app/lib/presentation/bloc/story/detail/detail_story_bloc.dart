import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/story_repository.dart';
import 'detail_story_event.dart';
import 'detail_story_state.dart';

class DetailStoryBloc extends Bloc<DetailStoryEvent, DetailStoryState> {
  final StoryRepository storyRepository;

  DetailStoryBloc(this.storyRepository) : super(const DetailStoryInitial()) {
    on<DetailStoryButtonPressed>(_onDetailStoryButtonPressed);
  }

  void _onDetailStoryButtonPressed(
      DetailStoryButtonPressed event, Emitter<DetailStoryState> emit) async {
    emit(const DetailStoryLoading());
    try {
      final stories = await storyRepository.getDetailStories(event.id);
      emit(DetailStorySuccess(stories: stories));
    } catch (error) {
      emit(DetailStoryFailure(error: error.toString()));
    }
  }
}
