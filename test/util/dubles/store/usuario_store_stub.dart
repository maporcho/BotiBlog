import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/business/usuario/state/usuario_state.dart';
import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/model/error.dart';

class UsuarioStoreStub extends UsuarioStore {
  final Auth auth;
  final bool loginComSucesso;
  final bool cadastroComSucesso;

  UsuarioStoreStub({
    this.auth,
    this.loginComSucesso = true,
    this.cadastroComSucesso = true,
  });

  @override
  Future efetuarLogin(String email, String senha) {
    state = loginComSucesso
        ? LoginSuccessState()
        : ErrorState(
            Error(message: 'Erro'),
          );
  }

  @override
  cadastrarUsuario(String nome, String email, String senha) {
    state = cadastroComSucesso
        ? CadastroSuccessState()
        : ErrorState(
            Error(message: 'Erro'),
          );
  }

  @override
  Future<Auth> obterInfoUsuarioLogado() async {
    return auth;
  }

  @override
  Future logout() {
    state = SaiuSuccessState();
  }
}
