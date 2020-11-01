import 'package:boti_blog/business/posts/state/posts_state.dart';
import 'package:boti_blog/business/posts/store/edit_posts_store.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/model/error.dart';

class EditPostsStoreStub extends EditPostsStore {
  final bool atualizarPostsComSucesso;
  final bool removerPostsComSucesso;

  EditPostsStoreStub({
    this.atualizarPostsComSucesso = true,
    this.removerPostsComSucesso = true,
  });

  @override
  adicionarOuAtualizarPost(
    String content, {
    Post postAAtualizar,
  }) async {
    state = atualizarPostsComSucesso
        ? PostAdicionadoOuAlteradoComSucessoState()
        : ErrorState(
            Error(message: 'Erro'),
          );
  }

  @override
  removerPost(
    Post post,
  ) async {
    state = atualizarPostsComSucesso
        ? PostAdicionadoOuAlteradoComSucessoState()
        : ErrorState(
            Error(message: 'Erro'),
          );
  }
}
