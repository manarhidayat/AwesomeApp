import 'dart:convert';
import 'package:awesome_app/data/models/photo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  final SharedPreferences prefs;

  CacheHelper(this.prefs);

  Future<bool> savePhotos(List<PhotoModel> list) async {
    List<String>? _dataList = list.map((value) {
      return jsonEncode(value.toJson());
    }).toList();
    return prefs.setStringList("photos", _dataList);
  }

  Future<List<T>> getPhotos<T>(T f(Map v),
      {List<T> defValue = const []}) async {
    List<Map>? dataList = _getPhotoList(prefs, "photos");
    if(dataList != null){
      List<T>? list = dataList.map((value) {
        return f(value);
      }).toList();
      return list;
    }
    return [];
  }

  List<Map>? _getPhotoList(SharedPreferences prefs, String key) {
    List<String>? dataList = prefs.getStringList(key);
    return dataList?.map((value) {
      Map _dataMap = jsonDecode(value);
      return _dataMap;
    }).toList();
  }
}