import 'package:awesome_app/core/styles/colors.dart';
import 'package:awesome_app/core/styles/styles.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  static const String routeName = "/detailPhoto";

  final Photo photo;
 
  DetailScreen(this.photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              floating: false,
              pinned: true,
              title: Text(photo.photographer),
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: photo.src.original,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Card(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              ),
            ),
          ];
        },
        body: ListTile(
          title: Text("Photographer: ", style: textDesc),
          subtitle: Text(photo.photographer, style: textPrimary),
          trailing: IconButton(
            icon: Icon(Icons.explore_rounded, color: colorPrimary),
            onPressed: () => launch(photo.photographerUrl),
          ),
        ),
      ),
    );
  }
} 