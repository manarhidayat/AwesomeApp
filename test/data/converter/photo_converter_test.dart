import 'package:awesome_app/data/converter/photo_converter.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/data/models/src_model.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("Photo Converter", (){
    test("Photo Convert", (){
      final model = PhotoModel(
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
      );

      final photo = PhotoConverter.convert(model);
      expect(photo, isA<Photo>());
    });

    test("Photo Converts", (){
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

      final photos = PhotoConverter.converts(models);
      expect(photos, isA<List<Photo>>());
    });
  });
}