// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioStore on _UsuarioStore, Store {
  final _$stateAtom = Atom(name: '_UsuarioStore.state');

  @override
  BaseState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(BaseState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$efetuarLoginAsyncAction = AsyncAction('_UsuarioStore.efetuarLogin');

  @override
  Future efetuarLogin(String email, String senha) {
    return _$efetuarLoginAsyncAction
        .run(() => super.efetuarLogin(email, senha));
  }

  final _$_UsuarioStoreActionController =
      ActionController(name: '_UsuarioStore');

  @override
  dynamic cadastrarUsuario(String nome, String email, String senha) {
    final _$actionInfo = _$_UsuarioStoreActionController.startAction(
        name: '_UsuarioStore.cadastrarUsuario');
    try {
      return super.cadastrarUsuario(nome, email, senha);
    } finally {
      _$_UsuarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
