
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/story_repository.dart';
import 'location_story_event.dart';
import 'location_story_state.dart';

class LocationStoryBloc extends Bloc<LocationStoryEvent, LocationStoryState> {
  final StoryRepository storyRepository;

  LocationStoryBloc(this.storyRepository) : super(const LocationStoryInitial()) {
    on<LocationStoryButtonPressed>(_onLocationStoryButtonPressed);
  }

  void _onLocationStoryButtonPressed(
      LocationStoryButtonPressed event, Emitter<LocationStoryState> emit) async {
    emit(const LocationStoryLoading());
    try {
      final stories = await storyRepository.getLocations();
      emit(LocationStorySuccess(stories: stories));
    } catch (error) {
      emit(LocationStoryFailure(error: error.toString()));
    }
  }
}


