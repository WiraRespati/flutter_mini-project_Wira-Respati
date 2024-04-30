import 'package:equatable/equatable.dart';

import '../../../../data/models/story/list_story_response.dart';

abstract class ListStoryState extends Equatable {
  const ListStoryState();

  @override
  List<Object?> get props => [];
}

class ListStoryInitial extends ListStoryState {
  const ListStoryInitial();
}

class ListStoryLoading extends ListStoryState {
  const ListStoryLoading();
}

class ListStorySuccess extends ListStoryState {
  final List<ListStory> stories;

  const ListStorySuccess({
    required this.stories,
  });

  ListStorySuccess copyWith({
    List<ListStory>? stories,
  }) {
    return ListStorySuccess(
      stories: stories ?? this.stories,
    );
  }
}

class ListStoryFailure extends ListStoryState {
  final String error;

  const ListStoryFailure({required this.error});
}
