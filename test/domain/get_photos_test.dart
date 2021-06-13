import 'dart:convert';

import 'package:awesome_app/data/converter/photo_response_converter.dart';
import 'package:awesome_app/data/models/photos_response_model.dart';
import 'package:awesome_app/domain/repositories/photo_repository.dart';
import 'package:awesome_app/domain/usecase/get_photos.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../util/json_reader.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main(){
  MockPhotoRepository _repository = MockPhotoRepository();
  GetPhotos _usecase = GetPhotos(repository: _repository);

  setUp((){
    _repository = MockPhotoRepository();
    _usecase = GetPhotos(repository: _repository);
  });

  test("Get Photos", () async {
    final map = json.decode(jsonReader("photos.json"));
    final photosResponseModel = PhotosResponseModel.fromJson(map);
    final photosResponse = PhotoResponseConverter.convert(photosResponseModel);

    when(_repository.photos(1)).thenAnswer((_) async => Right(photosResponse));
    final result = await _usecase(ParamsGetPhotos(1));

    expect(result, Right(photosResponse.photos));
    verify(_repository.photos(1));
    verifyNoMoreInteractions(_repository);
  });
}