import 'package:awesome_app/domain/entities/photo.dart';

class PhotosResponse {
  PhotosResponse({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
    required this.nextPage,
  });

  int page;
  int perPage;
  List<Photo> photos;
  int totalResults;
  String nextPage;
} 