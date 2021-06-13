import 'dart:convert';

import 'package:awesome_app/data/converter/photo_converter.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/domain/repositories/photo_repository.dart';
import 'package:awesome_app/domain/usecase/get_photo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../util/json_reader.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main(){
  MockPhotoRepository _repository = MockPhotoRepository();
  GetPhoto _usecase = GetPhoto(repository: _repository);

  setUp((){
    _repository = MockPhotoRepository();
    _usecase = GetPhoto(repository: _repository);
  });
  
  test("Get Photo", () async {
    final map = json.decode(jsonReader("photo.json"));
    final photoResponseModel = PhotoModel.fromJson(map);
    final photoResponse = PhotoConverter.convert(photoResponseModel);

    when(_repository.photo(1)).thenAnswer((_) async => Right(photoResponse));
    final result = await _usecase(ParamsGetPhoto(6399697));

    expect(result, Right(photoResponse));
    verify(_repository.photo(6399697));
    verifyNoMoreInteractions(_repository);
  });
}