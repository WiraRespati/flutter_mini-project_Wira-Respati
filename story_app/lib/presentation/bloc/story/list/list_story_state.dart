import 'package:equatable/equatable.dart';
import 'package:story_app/data/models/story/list_story_response.dart';

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
  final ListStoryResponse stories;

  const ListStorySuccess({
    required this.stories,
  });

  ListStorySuccess copyWith({
    required ListStoryResponse stories,
  }) {
    return ListStorySuccess(
      stories: stories,
    );
  }

  @override
  List<Object?> get props => [stories];
}

class ListStoryFailure extends ListStoryState {
  final String error;

  const ListStoryFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
