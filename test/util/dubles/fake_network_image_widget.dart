import 'package:boti_blog/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';

class FakeNetworkImageWidget extends NetworkImageWidget {
  @override
  _FakeNetworkImageWidgetState createState() => _FakeNetworkImageWidgetState();
}

class _FakeNetworkImageWidgetState extends State<FakeNetworkImageWidget> {
  @override
  Widget build(BuildContext context) => SizedBox.shrink();
}
