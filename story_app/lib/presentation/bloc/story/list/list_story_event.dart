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
