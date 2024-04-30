import 'package:equatable/equatable.dart';

abstract class LocationStoryEvent extends Equatable {
  const LocationStoryEvent();

  @override
  List<Object?> get props => [];
}

class LocationStoryButtonPressed extends LocationStoryEvent {
  const LocationStoryButtonPressed();

  @override
  List<Object?> get props => [];
}

