import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/infrastructure/posts_requester.dart';
import 'package:boti_blog/business/posts/state/posts_state.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/state/loading_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'posts_store.g.dart';

class PostsStore = _PostsStore with _$PostsStore;

abstract class _PostsStore extends BaseStore<BaseState> with Store {
  @observable
  BaseState state;

  int _idUsuarioLogado;

  @action
  obterPosts() async {
    state = LoadingState();

    var requester = GetIt.instance.get<PostsRequester>();

    await requester.obterPosts(onSuccess: (posts) {
      _obterIdUsuarioLogado();

      state = PostsCarregadosComSucessoState(posts);
    }, onFail: (erro) {
      state = ErrorState(erro);
    });
  }

  isPostDoUsuario(Post post) => post.user?.id == _idUsuarioLogado;

  void _obterIdUsuarioLogado() async {
    final sharedData = GetIt.instance.get<SharedData>();
    final authJson = await sharedData.get(Auth.KEY);
    final auth = (authJson != null) ? Auth.fromJson(authJson) : null;
    _idUsuarioLogado = auth?.id;
  }
}
