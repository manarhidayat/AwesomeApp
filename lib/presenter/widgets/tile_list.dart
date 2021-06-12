import 'package:awesome_app/core/styles/styles.dart';
import 'package:awesome_app/domain/entities/photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          child: Image.network(photo.src.medium, fit: BoxFit.cover,),
        ),
        title: Text("Photographer: ", style: textDesc),
        subtitle: Text(photo.photographer, style: textPrimary),
        trailing: Icon(
          Icons.favorite,
          color: photo.liked
              ? Colors.red
              : Colors.grey
        ),
      ),
    );
  }
} 