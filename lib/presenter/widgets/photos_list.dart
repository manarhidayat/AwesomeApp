import 'package:awesome_app/domain/entities/photo.dart';
import 'package:awesome_app/presenter/widgets/tile_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_loader.dart';

class PhotosList extends StatefulWidget {

  final List<Photo> photos;

  PhotosList(this.photos);

  @override
  PhotosListState createState() => PhotosListState();
}

class PhotosListState extends State<PhotosList> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index){
        final photo = widget.photos[index];
        return index >= widget.photos.length
                      ? BottomLoader()
                      : TileList(photo);
      },
      separatorBuilder: (context, index) => Container(),
      itemCount: widget.photos.length,
    );
  }
} 