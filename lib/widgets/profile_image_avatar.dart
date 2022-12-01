import 'package:flutter/material.dart';
import 'package:social_media_app/constants/constants.dart';

Widget profileImageAvatar({
  required String imageUrl,
  bool loading = false,
  double? diameter = 0,
}) {
  return Container(
    height: diameter != 0 ? diameter : 75,
    width: diameter != 0 ? diameter : 75,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(shape: BoxShape.circle),
    child: loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Image.network(
            imageUrl,
            fit: BoxFit.cover,
            // height: 110,
            // width: 110,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  value: loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!.toInt(),
                  strokeWidth: 4,
                ),
              );
            },
          ),
  );
}
