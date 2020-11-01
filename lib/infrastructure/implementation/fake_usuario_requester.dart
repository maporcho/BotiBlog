import 'dart:convert';

import 'package:boti_blog/infrastructure/usuario_requester.dart';
import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/business/usuario/model/usuario_cadastrado.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/model/error.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class FakeUsuarioRequester implements UsuarioRequester {
  final sharedData = GetIt.instance.get<SharedData>();

  static const _USUARIOS_FAKE_KEY = "_USUARIOS_FAKE_KEY";

  _criarUsuarioDeExemplo() {
    _salvarUsuariosCadastrados([
      UsuarioCadastrado(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: 'Marco Porcho',
        email: 'teste@teste.com',
        senha: '1234',
      )
    ]);
  }

  @override
  Future efetuarLogin({
    String email,
    String senha,
    Function onSuccess,
    Function onFail,
  }) async {
    final usuariosCadastrados = await _obterUsuariosCadastrados();

    await Future.delayed(Duration(seconds: 1), () {
      final usuario = usuariosCadastrados.firstWhere(
        (u) => u.email == email && u.senha == senha,
        orElse: () => null,
      );
      if (usuario != null) {
        onSuccess(
          Auth(
            id: usuario.id,
            nome: usuario.nome,
            token: 'mock.token',
            avatarUrl:
                'https://ih1.redbubble.net/image.402879777.9483/flat,128x128,075,t-pad,128x128,f8f8f8.jpg',
          ),
        );
      } else {
        onFail(Error(message: Strings.erroLogin));
      }
    });
  }

  @override
  Future cadastrar({
    @required String nome,
    @required String email,
    @required String senha,
    @required Function onSuccess,
    @required Function(Error) onFail,
  }) async {
    if (await _emailJaCadastrado(email)) {
      onFail(
        Error(
          message: Strings.erroCadastroExistente,
        ),
      );
    } else {
      _cadastrarUsuario(UsuarioCadastrado(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: nome,
        email: email,
        senha: senha,
      ));
      onSuccess();
    }
  }

  Future<bool> _emailJaCadastrado(String email) async {
    List<UsuarioCadastrado> usuariosCadastrados =
        await _obterUsuariosCadastrados();
    return usuariosCadastrados.any((u) => u.email == email);
  }

  Future<List<UsuarioCadastrado>> _obterUsuariosCadastrados() async {
    if (!(await sharedData.hasKey(_USUARIOS_FAKE_KEY))) {
      await _criarUsuarioDeExemplo();
    }

    String usuariosJson = await sharedData.get(_USUARIOS_FAKE_KEY);
    List<UsuarioCadastrado> usuarios = [];
    if (usuariosJson != null) {
      usuarios = (json.decode(usuariosJson) as List)
          .map((postJson) => UsuarioCadastrado.fromJson(postJson))
          .toList();
    }
    return usuarios;
  }

  Future _salvarUsuariosCadastrados(List<UsuarioCadastrado> usuarios) async {
    await sharedData.add(_USUARIOS_FAKE_KEY, jsonEncode(usuarios));
  }

  _cadastrarUsuario(UsuarioCadastrado usuarioCadastrado) async {
    List<UsuarioCadastrado> usuariosCadastrados =
        await _obterUsuariosCadastrados();
    usuariosCadastrados.add(usuarioCadastrado);
    _salvarUsuariosCadastrados(usuariosCadastrados);
  }
}
