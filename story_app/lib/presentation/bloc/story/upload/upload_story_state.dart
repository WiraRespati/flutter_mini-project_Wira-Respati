import 'package:equatable/equatable.dart';

abstract class UploadStoryState extends Equatable {
  const UploadStoryState();

  @override
  List<Object?> get props => [];
}

class UploadStoryInitial extends UploadStoryState {}

class UploadStoryLoading extends UploadStoryState {}

class UploadStorySuccess extends UploadStoryState {}

class UploadStoryFailure extends UploadStoryState {
  final String error;

  const UploadStoryFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
