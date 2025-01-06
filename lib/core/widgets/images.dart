import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/constant/constant.dart';

Widget cashImage(String? imageSource,
    {String? errorWidget,
    double? width,
    double? height,
    double? spinSize,
    double? widthAssetImage,
    double? heightAssetImage,
    BoxFit? fit,
    double loadingSize = 15}) {
  return (imageSource != null && imageSource.isNotEmpty)
      ? CachedNetworkImage(
          imageUrl: imageSource,
          errorWidget: (context, url, error) => Image.asset(errorWidget ?? Constants.error,
              width: width, height: height, color: Colors.white.withOpacity(0.3), colorBlendMode: BlendMode.modulate),
          progressIndicatorBuilder: (context, url, downloadProgress) => const CircularProgressIndicator(),
          width: width,
          height: height,
          fit: fit,
        )
      : Image.asset(errorWidget ?? Constants.error,
          width: width == null ? null : widthAssetImage ?? (width - 10),
          height: height == null ? null : heightAssetImage ?? (height - 10),
          color: Colors.white.withOpacity(0.3),
          colorBlendMode: BlendMode.modulate);
}
