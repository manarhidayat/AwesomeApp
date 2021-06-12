import 'package:awesome_app/core/styles/styles.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:awesome_app/presenter/screens/detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TileList extends StatelessWidget {

  const TileList(this.photo);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 80,
          height: 100,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: photo.src.medium,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Card(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        ),
        title: Text("Photographer: ", style: textDesc),
        subtitle: Text(photo.photographer, style: textPrimary),
        trailing: Icon(
          Icons.favorite,
          color: photo.liked
              ? Colors.red
              : Colors.grey
        ),
        onTap: () => Navigator.pushNamed(context, DetailScreen.routeName, arguments: photo),
      ),
    );
  }
} 