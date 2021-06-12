import 'package:awesome_app/domain/entities/photo.dart';
import 'package:equatable/equatable.dart';

enum PhotosStatus { initial, success, failure }

class PhotosState extends Equatable {
  const PhotosState({
    this.status = PhotosStatus.initial,
    this.list = const <Photo>[],
    this.hasReachedMax = false,
  });

  final PhotosStatus status;
  final List<Photo> list;
  final bool hasReachedMax;

  PhotosState copyWith({
    required PhotosStatus status,
    required List<Photo> list,
    required bool hasReachedMax,
  }) {
    return PhotosState(
      status: status,
      list: list,
      hasReachedMax: hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, list, hasReachedMax];
}