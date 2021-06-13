import 'package:awesome_app/data/converter/photo_response_converter.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/data/models/photos_response_model.dart';
import 'package:awesome_app/data/models/src_model.dart';
import 'package:awesome_app/domain/entities/photos_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final List<PhotoModel> models = [];

  for(int counter = 0; counter < 5; counter++){
    models.add(PhotoModel(
        id: 1,
        height: 1,
        avgColor: "test",
        liked: false,
        photographer: "test",
        photographerId: 1,
        photographerUrl: "test",
        src: SrcModel(
            tiny: "test",
            small: "test",
            portrait: "test",
            original: "test",
            medium: "test",
            large: "test",
            large2X: "test",
            landscape: "test"
        ),
        url: "test",
        width: 1
    ));
  }

  test("Photo Response Convert", (){
    final model = PhotosResponseModel(
        totalResults: 1,
        photos: models,
        perPage: 1,
        nextPage: "test",
        page: 1
    );

    final photo = PhotoResponseConverter.convert(model);
    expect(photo, isA<PhotosResponse>());
  });
}