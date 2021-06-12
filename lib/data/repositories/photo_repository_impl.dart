import 'package:awesome_app/core/error/failures.dart';
import 'package:awesome_app/data/datasource/photo_remote_datasource.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:awesome_app/domain/entities/photos_response.dart';
import 'package:awesome_app/domain/repositories/photo_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDatasource _remoteDatasource;

  PhotoRepositoryImpl({
    required PhotoRemoteDatasource remoteDatasource
  }): _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, Photo>> photo(int idPhoto) async {
    try {
      final getPhoto = await _remoteDatasource.getPhoto(idPhoto);
      return Right(getPhoto);
    } on DioError catch(_){
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PhotosResponse>> photos(int page) async {
    try {
      final getPhotos = await _remoteDatasource.getPhotos(page);
      return Right(getPhotos);
    } on DioError catch(_) {
      return Left(ServerFailure());
    }
  }

} 