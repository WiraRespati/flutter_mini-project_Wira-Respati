import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/repositories/story_repository.dart';
import 'package:story_app/presentation/bloc/story/list/list_story_event.dart';
import 'package:story_app/presentation/bloc/story/list/list_story_state.dart';

class ListStoryBloc extends Bloc<ListStoryEvent, ListStoryState> {
  final StoryRepository storyRepository;

  ListStoryBloc(this.storyRepository) : super(const ListStoryInitial()) {
    on<ListStoryButtonPressed>(_onListStoryButtonPressed);
    
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

 
}
