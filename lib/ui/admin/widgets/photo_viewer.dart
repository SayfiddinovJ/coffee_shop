import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: NetworkImage(url));
  }
}
