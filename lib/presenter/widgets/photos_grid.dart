import 'package:awesome_app/domain/entities/photo.dart';
import 'package:awesome_app/presenter/screens/detail_screen.dart';
import 'package:awesome_app/presenter/widgets/tile_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'bottom_loader.dart';

class PhotosGrid extends StatefulWidget {

  final List<Photo> photos;

  PhotosGrid(this.photos);

  @override
  PhotosGridState createState() => PhotosGridState();
}

class PhotosGridState extends State<PhotosGrid> {

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      primary: true,
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      itemCount: widget.photos.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index){
        final photo = widget.photos[index];
        return index >= widget.photos.length
          ? BottomLoader()
          : 
          GestureDetector(
            child: TileGrid(photo),
            onTap: () => Navigator.pushNamed(context, DetailScreen.routeName, arguments: photo),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    );
  }

} 