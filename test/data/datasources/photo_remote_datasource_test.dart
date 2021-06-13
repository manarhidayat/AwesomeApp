import 'dart:convert';

import 'package:awesome_app/core/network/api.dart';
import 'package:awesome_app/data/converter/photo_converter.dart';
import 'package:awesome_app/data/converter/photo_response_converter.dart';
import 'package:awesome_app/data/datasource/photo_remote_datasource.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/data/models/photos_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../util/json_reader.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main(){
  PhotoRemoteDatasourceImpl _dataSource = PhotoRemoteDatasourceImpl();
  DioAdapterMock _adapterMock = DioAdapterMock();

  setUp((){
    _adapterMock = DioAdapterMock();
    _dataSource = PhotoRemoteDatasourceImpl();
  });

  group("Photo Remote Datasource", (){
    test("Get Photo", () async {
      final photoJson = json.decode(jsonReader("photo.json"));

      when(_adapterMock.fetch(RequestOptions(path: Api.GET_DETAIL_PHOTO), any, any))
          .thenAnswer((_) async => ResponseBody.fromString(
        photoJson,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
          "Authorization": ["563492ad6f91700001000001994a2bccbbd7497e93b3a0ca2a6cdb08"]
        },
      ));

      final photo = await _dataSource.getPhoto(6010606);
      final model = PhotoModel.fromJson(photoJson);
      final expected = PhotoConverter.convert(model);

      identical(photo, expected);
    });

    test("Get Photos", () async {
      final photosJson = json.decode(jsonReader("photos.json"));

      when(_adapterMock.fetch(RequestOptions(path: Api.GET_PHOTOS), any, any))
          .thenAnswer((_) async => ResponseBody.fromString(
        photosJson,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
          "Authorization": ["563492ad6f91700001000001994a2bccbbd7497e93b3a0ca2a6cdb08"]
        },
      ));

      final photo = await _dataSource.getPhotos(1);
      final model = PhotosResponseModel.fromJson(photosJson);
      final expected = PhotoResponseConverter.convert(model);

      identical(photo, expected);
    });
  });
}