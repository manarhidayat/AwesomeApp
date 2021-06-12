import 'package:awesome_app/data/models/src_model.dart';
import 'package:awesome_app/domain/entities/src.dart';

class SrcConverter {
  static Src convert(SrcModel model){
    return Src(
      landscape: model.landscape,
      large2X: model.large2X,
      large: model.large,
      medium: model.medium,
      original: model.original,
      portrait: model.portrait,
      small: model.small,
      tiny: model.tiny
    );
  }
} 
