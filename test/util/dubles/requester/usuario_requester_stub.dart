import 'package:boti_blog/infrastructure/usuario_requester.dart';
import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/common/model/error.dart';

class UsuarioRequesterStubBuilder {
  static UsuarioRequester success({Auth auth}) =>
      _UsuarioRequesterStubSuccess(auth: auth);
  static UsuarioRequester fail(Error erro) => _UsuarioRequesterStubFail(erro);
}

class _UsuarioRequesterStubSuccess implements UsuarioRequester {
  final Auth auth;

  _UsuarioRequesterStubSuccess({this.auth});

  Future efetuarLogin({
    String email,
    String senha,
    Function(Auth) onSuccess,
    Function onFail,
  }) {
    onSuccess(auth);
  }

  Future cadastrar({
    String nome,
    String email,
    String senha,
    Function onSuccess,
    Function(Error) onFail,
  }) {
    onSuccess();
  }
}

class _UsuarioRequesterStubFail implements UsuarioRequester {
  final Error erro;

  _UsuarioRequesterStubFail(this.erro);

  Future efetuarLogin({
    String email,
    String senha,
    Function(Auth) onSuccess,
    Function onFail,
  }) {
    onFail(erro);
  }

  Future cadastrar({
    String nome,
    String email,
    String senha,
    Function onSuccess,
    Function(Error) onFail,
  }) {
    onFail(erro);
  }
}
