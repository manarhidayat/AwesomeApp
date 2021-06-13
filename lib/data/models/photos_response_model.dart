import 'package:awesome_app/data/models/photo_model.dart';

class PhotosResponseModel {
  PhotosResponseModel({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
    required this.nextPage,
  });

  int page;
  int perPage;
  List<PhotoModel> photos;
  int totalResults;
  String nextPage;

  factory PhotosResponseModel.fromJson(Map<String, dynamic> json) => PhotosResponseModel(
    page: json["page"] != null ? json["page"] : 1,
    perPage: json["per_page"] != null ? json["per_page"] : 1,
    photos: (json["photos"] != null) ? List<PhotoModel>.from(json["photos"].map((x) => PhotoModel.fromJson(x))) : [],
    totalResults: json["total_results"] != null ? json["total_results"] : 0,
    nextPage: json["next_page"] != null ? json["next_page"] : -1,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "total_results": totalResults,
    "next_page": nextPage,
  };
}