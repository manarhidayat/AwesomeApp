import 'package:awesome_app/data/converter/src_converter.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/domain/entities/photo.dart';

class PhotoConverter {
  static Photo convert(PhotoModel model){
    return Photo(
      id: model.id,
      height: model.height,
      avgColor: model.avgColor,
      liked: model.liked,
      photographer: model.photographer,
      photographerId: model.photographerId,
      photographerUrl: model.photographerUrl,
      src: SrcConverter.convert(model.src),
      url: model.url,
      width: model.width
    );
  }

  static List<Photo> converts(List<PhotoModel> models){
    final List<Photo> photos = [];

    for(PhotoModel model in models){
      photos.add(Photo(
        width: model.width,
        url: model.url,
        src: SrcConverter.convert(model.src),
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