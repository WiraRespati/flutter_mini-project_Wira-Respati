import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/models/story/list_story_response.dart';
import 'package:story_app/data/repositories/story_repository.dart';
import 'package:story_app/presentation/bloc/story/list/list_story_event.dart';
import 'package:story_app/presentation/bloc/story/list/list_story_state.dart';

class ListStoryBloc extends Bloc<ListStoryEvent, ListStoryState> {
  final StoryRepository storyRepository;

  ListStoryBloc(this.storyRepository) : super(const ListStoryInitial()) {
    on<ListStoryButtonPressed>(_onListStoryButtonPressed);
    on<LoadMoreStories>(_onLoadMoreStories);
  }

  void _onListStoryButtonPressed(
      ListStoryButtonPressed event, Emitter<ListStoryState> emit) async {
    emit(const ListStoryLoading());
    try {
      final stories = await storyRepository.getAllStories();
      emit(ListStorySuccess(stories: stories));
    } catch (error) {
      emit(ListStoryFailure(error: error.toString()));
    }
  }

  void _onLoadMoreStories(
    LoadMoreStories event, Emitter<ListStoryState> emit) async {
  try {
    if (state is ListStorySuccess) {
      final currentState = state as ListStorySuccess;

      final newStories =
          await storyRepository.getAllStories(page: event.nextPage);

      final updatedStories =
          currentState.stories.listStory! + newStories.listStory!;
      emit(ListStoryLoadMoreSuccess(
        stories: ListStoryResponse(listStory: updatedStories),
      ));
    } else {
      
    }
  } catch (error) {
    emit(ListStoryLoadMoreFailure(error: error.toString()));
  }
}
}
