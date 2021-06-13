import 'dart:convert';

import 'package:awesome_app/data/converter/photo_response_converter.dart';
import 'package:awesome_app/data/models/photos_response_model.dart';
import 'package:awesome_app/domain/usecase/get_photo.dart';
import 'package:awesome_app/domain/usecase/get_photos.dart';
import 'package:awesome_app/presenter/blocs/photos/photos_bloc.dart';
import 'package:awesome_app/presenter/blocs/photos/photos_event.dart';
import 'package:awesome_app/presenter/blocs/photos/photos_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../util/json_reader.dart';

class MockGetPhotos extends Mock implements GetPhotos {}

class MockGetPhoto extends Mock implements GetPhoto {}

void main(){
  MockGetPhotos _getPhotos = MockGetPhotos();
  PhotosBloc _bloc = PhotosBloc(getPhotos: _getPhotos);

  setUp((){
    _getPhotos = MockGetPhotos();

    _bloc = PhotosBloc(getPhotos: _getPhotos);
  });

  test("Initial state should be empty", (){
    expect(_bloc.state, equals(null));
  });

  group("Photos BLoC", (){
    final mapPhoto = json.decode(jsonReader("photos.json"));
    final photosResponseModel = PhotosResponseModel.fromJson(mapPhoto);
    final photosResponse = PhotoResponseConverter.convert(photosResponseModel);

    blocTest("Should return data empty when call photos loaded",
      build: () => _bloc,
      act: (PhotosBloc bloc) => bloc.add(PhotosInitial()),
      expect: () => PhotosState(status: PhotosStatus.success, list: photosResponse.photos, hasReachedMax: false),
    );

    blocTest("Should return data when call photos loaded",
      build: () => _bloc,
      act: (PhotosBloc bloc){
        when(_getPhotos(ParamsGetPhotos(1)))
            .thenAnswer((_) async => Right(photosResponse));

        bloc.add(PhotosFetched());
      },
      expect: () => PhotosState(status: PhotosStatus.success, list: photosResponse.photos, hasReachedMax: false),
      verify: (_){
        verify(_getPhotos(ParamsGetPhotos(1)));
      },
    );
  });
}