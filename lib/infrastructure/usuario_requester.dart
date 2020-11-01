import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/common/model/error.dart';
import 'package:flutter/foundation.dart';

abstract class UsuarioRequester {
  Future efetuarLogin({
    @required String email,
    @required String senha,
    @required Function(Auth) onSuccess,
    @required Function(Error) onFail,
  });

  Future cadastrar({
    @required String nome,
    @required String email,
    @required String senha,
    @required Function onSuccess,
    @required Function(Error) onFail,
  });
}
