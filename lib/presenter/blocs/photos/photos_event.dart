import 'package:equatable/equatable.dart';

abstract class PhotosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotosFetched extends PhotosEvent {}
class PhotosInitial extends PhotosEvent {}