import 'package:boti_blog/ui/page/novidades_page.dart';
import 'package:boti_blog/ui/page/perfil_page.dart';
import 'package:boti_blog/ui/page/posts_page.dart';
import 'package:flutter/material.dart';

class PageContainer extends StatefulWidget {
  PageContainer(this.destination, {Key key}) : super(key: key);

  final Destination destination;

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.destination) {
      case Destination.Novidades:
        return NovidadesPage();
      case Destination.Posts:
        return PostsPage();
      case Destination.Perfil:
        return PerfilPage();
    }

    throw UnimplementedError('Unknow destination!');
  }
}

enum Destination { Novidades, Posts, Perfil }
