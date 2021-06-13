import 'package:awesome_app/data/converter/src_model_converter.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/domain/entities/photo.dart';

class PhotoModelConverter {
  static PhotoModel convert(Photo model){
    return PhotoModel(
        id: model.id,
        height: model.height,
        avgColor: model.avgColor,
        liked: model.liked,
        photographer: model.photographer,
        photographerId: model.photographerId,
        photographerUrl: model.photographerUrl,
        src: SrcModelConverter.convert(model.src),
        url: model.url,
        width: model.width
    );
  }

  static List<PhotoModel> converts(List<Photo> models){
    final List<PhotoModel> photos = [];

    for(Photo model in models){
      photos.add(PhotoModel(
          width: model.width,
          url: model.url,
          src: SrcModelConverter.convert(model.src),
          photographerUrl: model.photographerUrl,
          photographerId: model.photographerId,
          photographer: model.photographer,
          liked: model.liked,
          avgColor: model.avgColor,
          height: model.height,
          id: model.id
      ));
    }

    return photos;
  }
}