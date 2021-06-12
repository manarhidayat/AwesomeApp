import 'package:awesome_app/core/network/api.dart';
import 'package:awesome_app/core/network/util.dart';
import 'package:awesome_app/data/converter/photo_converter.dart';
import 'package:awesome_app/data/converter/photo_response_converter.dart';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:awesome_app/data/models/photos_response_model.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:awesome_app/domain/entities/photos_response.dart';
import 'package:dio/dio.dart';

abstract class PhotoRemoteDatasource {
  Future<PhotosResponse> getPhotos(int page);
  Future<Photo> getPhoto(int idPhoto);
}

class PhotoRemoteDatasourceImpl implements PhotoRemoteDatasource {
  @override
  Future<Photo> getPhoto(int idPhoto) async {
    final dio = Dio();

    final headers = await Util.apiKey();

    final responseJson = await dio.get(
      "${Api.GET_DETAIL_PHOTO}/$idPhoto",
      options: Options(
        headers: headers
      )
    );

    final photo = PhotoModel.fromJson(responseJson.data);
    return PhotoConverter.convert(photo);
  }

  @override
  Future<PhotosResponse> getPhotos(int page) async {
    final dio = Dio();

    final params = Map<String, dynamic>();
    params["page"] = page;

    final headers = await Util.apiKey();

    final responseJson = await dio.get(
      Api.GET_PHOTOS,
      queryParameters: params,
      options: Options(
        headers: headers
      )
    );

    final photos = PhotosResponseModel.fromJson(responseJson.data);
    return PhotoResponseConverter.convert(photos);
  }

} 