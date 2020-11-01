import 'package:boti_blog/common/model/post.dart';
import 'package:flutter/material.dart';

abstract class PageRouter {
  Future<Widget> initialPage();

  pushLoginPage(BuildContext context);

  pushTabsPage(BuildContext context);

  pushCadastroPage(BuildContext context);

  Future pushEditPost(
    BuildContext context,
    Post post,
  );

  voltar<T extends Object>(BuildContext context, [T result]);
}
