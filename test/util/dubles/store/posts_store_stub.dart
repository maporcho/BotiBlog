import 'package:boti_blog/business/posts/state/posts_state.dart';
import 'package:boti_blog/business/posts/store/posts_store.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/model/error.dart';

class PostsStoreStub extends PostsStore {
  final List<Post> posts;
  final bool obterPostsComSucesso;
  final int mockIdUsuarioLogado;

  PostsStoreStub({
    this.posts,
    this.obterPostsComSucesso = true,
    this.mockIdUsuarioLogado,
  });

  @override
  Future obterPosts() {
    state = obterPostsComSucesso
        ? PostsCarregadosComSucessoState(posts ?? [])
        : ErrorState(
            Error(message: 'Erro'),
          );
  }

  @override
  isPostDoUsuario(Post post) => post.user?.id == mockIdUsuarioLogado;
}
