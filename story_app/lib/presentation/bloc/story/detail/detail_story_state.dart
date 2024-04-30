import 'package:equatable/equatable.dart';

import '../../../../data/models/story/detail_story_response.dart';

abstract class DetailStoryState extends Equatable {
  const DetailStoryState();

  @override
  List<Object?> get props => [];
}

class DetailStoryInitial extends DetailStoryState {
  const DetailStoryInitial();
}

class DetailStoryLoading extends DetailStoryState {
  const DetailStoryLoading();
}

class DetailStorySuccess extends DetailStoryState {
  final DetailStory stories;

  const DetailStorySuccess({
    required this.stories,
  });

  @override
  List<Object?> get props => [stories];
}

class DetailStoryFailure extends DetailStoryState {
  final String error;

  const DetailStoryFailure({required this.error});
}
