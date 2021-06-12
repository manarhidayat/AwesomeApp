import 'package:awesome_app/core/error/failures.dart';
import 'package:awesome_app/core/usecase.dart';
import 'package:awesome_app/domain/entities/photos_response.dart';
import 'package:awesome_app/domain/repositories/photo_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ParamsGetPhotos extends Equatable {
  final int page;

  const ParamsGetPhotos(this.page);

  @override
  List<Object> get props => [page];
}

class GetPhotos extends UseCase<PhotosResponse, ParamsGetPhotos> {
  final PhotoRepository _repository;

  GetPhotos({
    required PhotoRepository repository
  }): _repository = repository;

  @override
  Future<Either<Failure, PhotosResponse>> call(ParamsGetPhotos params) async {
    return await _repository.photos(params.page);
  }
} 