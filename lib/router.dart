import 'package:awesome_app/presenter/screens/detail_screen.dart';
import 'package:awesome_app/presenter/screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'domain/entities/photo.dart';

class RouterGenerator {
  static MaterialPageRoute<dynamic> _moveTo(Widget view){
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> generatedRoute(RouteSettings settings){
    switch(settings.name){
      case MainScreen.routeName:
        return _moveTo(MainScreen());
      case DetailScreen.routeName:
      final args = settings.arguments as Photo;
        return _moveTo(DetailScreen(args));
      default:
        return _moveTo(MainScreen());
    }
  }
} 