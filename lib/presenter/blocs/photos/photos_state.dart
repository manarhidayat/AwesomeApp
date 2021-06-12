import 'package:awesome_app/domain/entities/photos_response.dart';
import 'package:equatable/equatable.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosLoadInProgress extends PhotosState {}

class PhotosLoadSuccess extends PhotosState {
  final PhotosResponse response;

  const PhotosLoadSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class PhotosEmpty extends PhotosState {}

class PhotosLoadFailed extends PhotosState {}

class PhotosUpdateFailed extends PhotosState {} 