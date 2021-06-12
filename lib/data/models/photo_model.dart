import 'package:awesome_app/data/models/src_model.dart';

class PhotoModel {
  PhotoModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
  });

  int id;
  int width;
  int height;
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  String avgColor;
  SrcModel src;
  bool liked;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
    id: json["id"] != null ? json["id"] : -1,
    width: json["width"] != null ? json["width"] : 0,
    height: json["height"] != null ? json["height"] : 0,
    url: json["url"] != null ? json["url"] : '',
    photographer: json["photographer"] != null ? json["photographer"] : '',
    photographerUrl: json["photographer_url"] != null ? json["photographer_url"] : '',
    photographerId: json["photographer_id"] != null ? json["photographer_id"] : -1,
    avgColor: json["avg_color"] != null ? json["avg_color"] : '',
    src: SrcModel.fromJson(json["src"]),
    liked: json["liked"] != null ? json["liked"] : false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "url": url,
    "photographer": photographer,
    "photographer_url": photographerUrl,
    "photographer_id": photographerId,
    "avg_color": avgColor,
    "src": src.toJson(),
    "liked": liked,
  };
}