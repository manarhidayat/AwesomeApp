import 'package:awesome_app/core/styles/styles.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TileGrid extends StatelessWidget {

  const TileGrid(this.photo);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: CachedNetworkImage(
            fit: BoxFit.fitWidth,
            imageUrl: photo.src.medium,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Card(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 12),
          child: Row(children: [
            Expanded(
              child: Column(children: [
                Text("Photographer: ", style: textDesc),
                Text(photo.photographer, style: textPrimary)
              ], crossAxisAlignment: CrossAxisAlignment.start),
            ),
            Icon(
              Icons.favorite,
              color: photo.liked
                  ? Colors.red
                  : Colors.grey
            )
          ]),
        )
      ]),
    );
  }
} 