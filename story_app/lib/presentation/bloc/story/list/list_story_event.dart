import 'package:equatable/equatable.dart';

abstract class ListStoryEvent extends Equatable {
  const ListStoryEvent();

  @override
  List<Object?> get props => [];
}

class ListStoryButtonPressed extends ListStoryEvent {
  const ListStoryButtonPressed();

  @override
  List<Object?> get props => [];
}

class LoadMoreStories extends ListStoryEvent {
  final int nextPage;

  const LoadMoreStories({required this.nextPage});

  @override
  List<Object?> get props => [nextPage];
}