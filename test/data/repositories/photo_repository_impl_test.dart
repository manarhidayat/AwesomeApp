import 'dart:convert';

import 'package:awesome_app/core/network/network_info..dart';
import 'package:awesome_app/data/converter/photo_converter.dart';
import 'package:awesome_app/data/converter/photo_response_converter.dart';
import 'package:awesome_app/data/datasource/photo_local_datasource.dart';
import 'package:awesome_app/data/datasource/photo_remote_datasource.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/data/models/photos_response_model.dart';
import 'package:awesome_app/domain/entities/photos_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../util/json_reader.dart';

class MockRemoteDataSource extends Mock implements PhotoRemoteDatasource {}

class MockLocalDataSource extends Mock implements PhotoLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  PhotoRemoteDatasourceImpl _repository = PhotoRemoteDatasourceImpl();
  MockRemoteDataSource _remoteDatasource = MockRemoteDataSource();
  MockLocalDataSource _localDatasource = MockLocalDataSource();

  setUp((){
    _repository = PhotoRemoteDatasourceImpl();
    _remoteDatasource = MockRemoteDataSource();
    _localDatasource = MockLocalDataSource();
  });

  group("Photo Repository", (){
    test("Should return remote data photos", () async {
      final map = json.decode(jsonReader("photos.json"));
      final photosResponseModel = PhotosResponseModel.fromJson(map);
      final photosResponse = PhotoResponseConverter.convert(photosResponseModel);
      
      when(_remoteDatasource.getPhotos(1))
        .thenAnswer((_) async => photosResponse);

      final result = await _repository.getPhotos(1);
      identical(result, PhotoResponseConverter.convert(photosResponseModel));
    });

    test("Should return remote data photo", () async {
      final map = json.decode(jsonReader("photo.json"));
      final photoModel = PhotoModel.fromJson(map);
      final photo = PhotoConverter.convert(photoModel);

      when(_remoteDatasource.getPhoto(1))
        .thenAnswer((_) async => photo);

      final result = await _repository.getPhoto(6399697);
      identical(result, PhotoConverter.convert(photoModel));
    });

    test("Should return local data photos", () async {
      final map = json.decode(jsonReader("photos.json"));
      final photosResponseModel = PhotosResponseModel.fromJson(map);
      final photosResponse = PhotoResponseConverter.convert(photosResponseModel);

      when(_localDatasource.getPhotos())
          .thenAnswer((_) async => photosResponse.photos);
      final result = await _repository.getPhotos(1);

      expect(result, isA<PhotosResponse>());
      identical(result, PhotoResponseConverter.convert(photosResponseModel));
    });
  });
}