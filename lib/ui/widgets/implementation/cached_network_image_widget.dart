import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../network_image_widget.dart';

class CachedNetworkImageWidget extends NetworkImageWidget {
  @override
  _CachedNetworkImageWidgetState createState() =>
      _CachedNetworkImageWidgetState();
}

class _CachedNetworkImageWidgetState extends State<CachedNetworkImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: widget.width ?? 50.0,
        height: widget.height ?? 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => widget.errorWidget,
      placeholder: widget.placeholder,
    );
  }
}
