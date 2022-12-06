import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String pathImage;
  final double? height;
  final double? width;
  ImageCard({required this.pathImage, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (pathImage.isNotEmpty) {
      CachedNetworkImage _cachedNetworkImage;
      if (height == null && width != null) {
        _cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL$pathImage',
          width: width,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      } else if (height != null && width == null) {
        _cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL$pathImage',
          height: height,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      } else if (height != null && width != null) {
        _cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL$pathImage',
          width: width,
          height: height,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      } else {
        _cachedNetworkImage = CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL$pathImage',
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      }
      return _cachedNetworkImage;
    } else {
      return Image.asset(
        "assets/no_image.png",
        fit: BoxFit.cover,
        height: 60,
        width: 70,
      );
    }
  }
}
