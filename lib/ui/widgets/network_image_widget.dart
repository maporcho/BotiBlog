import 'package:flutter/material.dart';

abstract class NetworkImageWidget extends StatefulWidget {
  String imageUrl;
  double width;
  double height;
  Widget errorWidget;
  Function(BuildContext context, String url) placeholder;
}
