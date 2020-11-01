import 'package:boti_blog/business/posts/state/posts_state.dart';
import 'package:boti_blog/business/posts/store/posts_store.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:boti_blog/common/ui/page_state.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/colors.dart';
import 'package:boti_blog/ui/widgets/post_item.dart';
import 'package:boti_blog/ui/widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends PageState<PostsPage> {
  PostsStore _postsStore;

  @override
  void initState() {
    _postsStore = GetIt.instance.get<PostsStore>();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _postsStore.obterPosts();
  }

  @override
  BaseStore<BaseState> getStore() => _postsStore;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          Strings.postsTitle,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Observer(
            builder: (_) {
              if (_postsStore.state is PostsCarregadosComSucessoState) {
                List<Post> posts =
                    (_postsStore.state as PostsCarregadosComSucessoState).posts;
                return (posts ?? []).isNotEmpty
                    ? ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostItem(
                            autor: posts[index].user.name,
                            criadoEm: posts[index].message.createdAt,
                            texto: posts[index].message.content,
                            urlAvatarUsuario: posts[index].user.profilePicture,
                            editavel: _postsStore.isPostDoUsuario(posts[index]),
                            onPressed: () {
                              if (_postsStore.isPostDoUsuario(posts[index])) {
                                _editarPost(post: posts[index]);
                              }
                            },
                          );
                        },
                      )
                    : listaVazia(
                        mensagem: Strings.postsListaVazia,
                        onTentarNovamente: () {
                          _postsStore.obterPosts();
                        },
                      );
              } else if (_postsStore.state is ErrorState) {
                return RetryWidget(
                  message: Strings.postsErroAoCarregar,
                  onTap: () {
                    _postsStore.obterPosts();
                  },
                );
              } else
                return SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _editarPost();
        },
        child: Icon(FontAwesomeIcons.plus),
        backgroundColor: BotiBlogColors.viridian,
      ),
    );
  }

  _editarPost({Post post}) {
    GetIt.instance
        .get<PageRouter>()
        .pushEditPost(context, post)
        .then((atualizarListaDePosts) {
      if (atualizarListaDePosts ?? false) {
        _postsStore.obterPosts();
      }
    });
  }
}
