import 'package:awesome_app/data/converter/photo_model_converter.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:awesome_app/domain/entities/src.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("Photo Model Converter", (){
    test("Photo Model Convert", (){
      final model = Photo(
          id: 1,
          height: 1,
          avgColor: "test",
          liked: false,
          photographer: "test",
          photographerId: 1,
          photographerUrl: "test",
          src: Src(
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

      final photo = PhotoModelConverter.convert(model);
      expect(photo, isA<PhotoModel>());
    });

    test("Photo Model Converts", (){
      final List<Photo> models = [];

      for(int counter = 0; counter < 5; counter++){
        models.add(Photo(
            id: 1,
            height: 1,
            avgColor: "test",
            liked: false,
            photographer: "test",
            photographerId: 1,
            photographerUrl: "test",
            src: Src(
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

      final photos = PhotoModelConverter.converts(models);
      expect(photos, isA<List<PhotoModel>>());
    });
  });
}