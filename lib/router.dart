import 'package:awesome_app/presenter/screens/detail_screen.dart';
import 'package:awesome_app/presenter/screens/main_screen.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static MaterialPageRoute<dynamic> _moveTo(Widget view){
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> generatedRoute(RouteSettings settings){
    switch(settings.name){
      case MainScreen.routeName:
        return _moveTo(MainScreen());
      case DetailScreen.routeName:
        return _moveTo(DetailScreen());
      default:
        return _moveTo(MainScreen());
    }
  }
} 