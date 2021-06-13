import 'package:awesome_app/core/error/exceptions.dart';
import 'package:awesome_app/core/error/failures.dart';
import 'package:awesome_app/core/network/network_info..dart';
import 'package:awesome_app/data/datasource/photo_local_datasource.dart';
import 'package:awesome_app/data/datasource/photo_remote_datasource.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:awesome_app/domain/entities/photos_response.dart';
import 'package:awesome_app/domain/repositories/photo_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDatasource _remoteDatasource;
  final PhotoLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  PhotoRepositoryImpl({
    required PhotoRemoteDatasource remoteDatasource,
    required PhotoLocalDatasource localDatasource,
    required NetworkInfo networkInfo
  }): _remoteDatasource = remoteDatasource,
      _localDatasource = localDatasource,
      _networkInfo = networkInfo;

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
    final isConnected = await _networkInfo.isConnected;
    if(isConnected){
      try {
        final getPhotos = await _remoteDatasource.getPhotos(page);
        _localDatasource.savePhotos(getPhotos.photos);
        return Right(getPhotos);
      } on DioError catch(_) {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final getPhotos = await _localDatasource.getPhotos();
        var response = PhotosResponse(nextPage: '1', page: 1, perPage: 1, totalResults: getPhotos.length, photos: getPhotos);
        return Right(response);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

} 