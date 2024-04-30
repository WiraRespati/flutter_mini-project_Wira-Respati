import 'package:equatable/equatable.dart';

import '../../../../data/models/story/list_story_response.dart';

abstract class LocationStoryState extends Equatable {
  const LocationStoryState();

  @override
  List<Object?> get props => [];
}

class LocationStoryInitial extends LocationStoryState {
  const LocationStoryInitial();
}

class LocationStoryLoading extends LocationStoryState {
  const LocationStoryLoading();
}

class LocationStorySuccess extends LocationStoryState {
  final List<ListStory> stories;

  const LocationStorySuccess({
    required this.stories,
  });

  LocationStorySuccess copyWith({
    List<ListStory>? stories,
  }) {
    return LocationStorySuccess(
      stories: stories ?? this.stories,
    );
  }
}

class LocationStoryFailure extends LocationStoryState {
  final String error;

  const LocationStoryFailure({required this.error});
}
