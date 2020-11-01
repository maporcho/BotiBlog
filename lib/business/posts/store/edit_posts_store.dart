import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/infrastructure/posts_requester.dart';
import 'package:boti_blog/business/posts/state/posts_state.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/state/loading_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'edit_posts_store.g.dart';

class EditPostsStore = _EditPostsStore with _$EditPostsStore;

abstract class _EditPostsStore extends BaseStore<BaseState> with Store {
  @observable
  BaseState state;

  @action
  adicionarOuAtualizarPost(
    String content, {
    Post postAAtualizar,
  }) async {
    state = LoadingState();

    Post post = postAAtualizar != null
        ? _atualizarPost(postAAtualizar, content)
        : await _criarNovoPost(content);

    final requester = GetIt.instance.get<PostsRequester>();

    await requester.adicionarOuAtualizarPost(
        postNovoOuAtualizado: post,
        onSuccess: () {
          state = PostAdicionadoOuAlteradoComSucessoState();
        },
        onFail: (erro) {
          state = ErrorState(erro);
        });
  }

  @action
  removerPost(
    Post post,
  ) async {
    state = LoadingState();

    final requester = GetIt.instance.get<PostsRequester>();

    await requester.remover(
        post: post,
        onSuccess: () {
          state = PostAdicionadoOuAlteradoComSucessoState();
        },
        onFail: (erro) {
          state = ErrorState(erro);
        });
  }

  Post _atualizarPost(Post post, String content) {
    post.message.content = content;
    return post;
  }

  Future<Post> _criarNovoPost(String content) async {
    final usuarioStore = GetIt.instance.get<UsuarioStore>();
    final auth = await usuarioStore.obterInfoUsuarioLogado();

    return Post(
      message: Message(
        content: content,
      ),
      user: User(
        id: auth.id,
        name: auth.nome,
        profilePicture: auth.avatarUrl,
      ),
    );
  }
}
