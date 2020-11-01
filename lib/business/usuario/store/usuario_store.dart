import 'package:boti_blog/infrastructure/usuario_requester.dart';
import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/business/usuario/state/usuario_state.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/state/loading_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:get_it/get_it.dart';

import 'package:mobx/mobx.dart';

part 'usuario_store.g.dart';

class UsuarioStore = _UsuarioStore with _$UsuarioStore;

abstract class _UsuarioStore extends BaseStore<BaseState> with Store {
  @observable
  BaseState state;

  @action
  efetuarLogin(
    String email,
    String senha,
  ) async {
    state = LoadingState();

    var requester = GetIt.instance.get<UsuarioRequester>();

    requester.efetuarLogin(
      email: email,
      senha: senha,
      onSuccess: (auth) {
        _salvarInfoUsuarioLogado(auth);
        state = LoginSuccessState();
      },
      onFail: (error) {
        state = ErrorState(error);
      },
    );
  }

  @action
  cadastrarUsuario(
    String nome,
    String email,
    String senha,
  ) {
    state = LoadingState();

    var requester = GetIt.instance.get<UsuarioRequester>();

    requester.cadastrar(
      nome: nome,
      email: email,
      senha: senha,
      onSuccess: () {
        state = CadastroSuccessState();
      },
      onFail: (error) {
        state = ErrorState(error);
      },
    );
  }

  Future<Auth> obterInfoUsuarioLogado() async {
    var sharedData = GetIt.instance.get<SharedData>();
    Auth auth;
    if (await sharedData.hasKey(Auth.KEY)) {
      var authJson = await sharedData.get(Auth.KEY);
      auth = Auth.fromJson(authJson);
    }
    return auth;
  }

  Future logout() async {
    state = LoadingState();

    var sharedData = GetIt.instance.get<SharedData>();
    await sharedData.remove(Auth.KEY);

    state = SaiuSuccessState();
  }

  void _salvarInfoUsuarioLogado(Auth auth) {
    var sharedData = GetIt.instance.get<SharedData>();
    sharedData.add(Auth.KEY, auth.toJson());
  }
}
