import 'package:equatable/equatable.dart';

abstract class DetailStoryEvent extends Equatable {
  const DetailStoryEvent();

  @override
  List<Object?> get props => [];
}

class DetailStoryButtonPressed extends DetailStoryEvent {
  final String id;

  const DetailStoryButtonPressed(this.id);

  @override
  List<Object?> get props => [id];
}

