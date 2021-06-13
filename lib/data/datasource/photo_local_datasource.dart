import 'package:awesome_app/core/cache_helper.dart';
import 'package:awesome_app/data/converter/photo_converter.dart';
import 'package:awesome_app/data/converter/photo_model_converter.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/domain/entities/photo.dart';

abstract class PhotoLocalDatasource {
  Future<List<Photo>> getPhotos();
  Future<bool> savePhotos(List<Photo> photos);
}

class PhotoLocalDatasourceImpl implements PhotoLocalDatasource {
  final CacheHelper cache;

  PhotoLocalDatasourceImpl(this.cache);

  @override
  Future<List<Photo>> getPhotos() async {
    final photos = await cache.getPhotos<Photo>((v){
      final model = PhotoModel.fromJson(v);
      return PhotoConverter.convert(model);
    });
    return photos;
  }

  @override
  Future<bool> savePhotos(List<Photo> photos) async { 
    final allPhoto = PhotoModelConverter.converts(photos);
    return await cache.savePhotos(allPhoto);
  }
}