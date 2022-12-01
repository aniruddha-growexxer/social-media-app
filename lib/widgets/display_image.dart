import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final bool isLoading;
  final VoidCallback onPressed;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.isLoading,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = COLORS.secondaryColorLight;

    return Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Stack(children: [
                buildImage(color),
                Positioned(
                  child: GestureDetector(
                    child: buildEditIcon(color),
                    onTap: onPressed,
                  ),
                  right: 4,
                  top: 10,
                )
              ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.network(
          imagePath,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 4,
              color: COLORS.secondaryColor,
            );
          },
        ),
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
