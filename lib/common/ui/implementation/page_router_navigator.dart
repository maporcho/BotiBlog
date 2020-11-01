import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/ui/page/cadastro_page.dart';
import 'package:boti_blog/ui/page/edit_post_page.dart';
import 'package:boti_blog/ui/page/login_page.dart';
import 'package:boti_blog/ui/page/tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../page_router.dart';

class PageRouterNavigator extends PageRouter {
  @override
  Future<Widget> initialPage() async {
    var isLogado = await isUsuarioLogado();
    return isLogado ? TabsPage() : LoginPage();
  }

  isUsuarioLogado() async =>
      await GetIt.instance.get<SharedData>().hasKey(Auth.KEY);

  @override
  pushLoginPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (_) => false,
    );
  }

  @override
  pushTabsPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => TabsPage(),
      ),
      (_) => false,
    );
  }

  @override
  pushCadastroPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroPage(),
      ),
    );
  }

  @override
  voltar<T extends Object>(BuildContext context, [T result]) {
    Navigator.pop(context, result);
  }

  @override
  Future pushEditPost(
    BuildContext context,
    Post post,
  ) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => EditPostPage(
          post: post,
        ),
      ),
    );
  }
}
