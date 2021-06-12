import 'package:dartz/dartz.dart';
import 'package:awesome_app/core/error/failures.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:awesome_app/domain/entities/photos_response.dart';

abstract class PhotoRepository {
  Future<Either<Failure, PhotosResponse>> photos(int page);
  Future<Either<Failure, Photo>> photo(int idPhoto);
}