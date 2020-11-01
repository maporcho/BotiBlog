import 'package:boti_blog/infrastructure/usuario_requester.dart';
import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/business/usuario/state/usuario_state.dart';
import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:boti_blog/common/model/error.dart';

import '../../../util/mass/auth_test_mass.dart';

import '../../../util/dubles/shared_data_mock.dart';
import '../../../util/dubles/requester/usuario_requester_stub.dart';
import '../../../util/test_injector.dart';

final usuarioStore = UsuarioStore();

final mockSharedData = MockSharedData();

void main() {
  group('[UsuarioStore tests - login]', () {
    setUpAll(() {
      when(mockSharedData.get(Auth.KEY)).thenAnswer(
        (_) => Future.value(authJsonDeTeste),
      );

      TestInjector.add<SharedData>(implementation: mockSharedData);
    });

    setUp(() {
      reset(mockSharedData);
    });

    test('Sucesso ao efetuar login', () async {
      TestInjector.add<UsuarioRequester>(
        implementation: UsuarioRequesterStubBuilder.success(
          auth: authDeTeste,
        ),
      );

      await usuarioStore.efetuarLogin('email@email.com', '1234');

      expect(
        usuarioStore.state.runtimeType,
        LoginSuccessState,
      );

      verify(
        mockSharedData.add(
          Auth.KEY,
          authDeTeste.toJson(),
        ),
      );
    });

    test('Falha ao efetuar login', () async {
      TestInjector.add<UsuarioRequester>(
        implementation: UsuarioRequesterStubBuilder.fail(
          Error(
            message: 'falhou',
          ),
        ),
      );

      await usuarioStore.efetuarLogin('email@email.com', '1234');

      expect(
        usuarioStore.state.runtimeType,
        ErrorState,
      );

      verifyZeroInteractions(mockSharedData);
    });
  });

  group('[UsuarioStore tests - cadastrar usuário]', () {
    test('Sucesso ao cadastrar usuário', () async {
      TestInjector.add<UsuarioRequester>(
        implementation: UsuarioRequesterStubBuilder.success(),
      );

      await usuarioStore.cadastrarUsuario(
        'Beltrano',
        'email@email.com',
        '1234',
      );

      expect(
        usuarioStore.state.runtimeType,
        CadastroSuccessState,
      );
    });

    test('Falha ao cadastrar usuário', () async {
      TestInjector.add<UsuarioRequester>(
        implementation: UsuarioRequesterStubBuilder.fail(
          Error(message: 'erro'),
        ),
      );

      await usuarioStore.cadastrarUsuario(
        'Beltrano',
        'email@email.com',
        '1234',
      );

      expect(
        usuarioStore.state.runtimeType,
        ErrorState,
      );
    });
  });

  group('[UsuarioStore tests - obter informações do usuário]', () {
    setUpAll(() {
      TestInjector.add<SharedData>(implementation: mockSharedData);
    });

    setUp(() {
      reset(mockSharedData);
    });

    test('Usuário não logado', () async {
      when(mockSharedData.hasKey(Auth.KEY)).thenAnswer(
        (_) => Future.value(false),
      );

      final auth = await usuarioStore.obterInfoUsuarioLogado();

      expect(
        auth,
        null,
      );
    });

    test('Usuário logado', () async {
      when(mockSharedData.hasKey(Auth.KEY)).thenAnswer(
        (_) => Future.value(true),
      );
      when(mockSharedData.get(Auth.KEY)).thenAnswer(
        (_) => Future.value(authJsonDeTeste),
      );

      final auth = await usuarioStore.obterInfoUsuarioLogado();

      expect(
        auth,
        authDeTeste,
      );
    });
  });

  group('[UsuarioStore tests - logout]', () {
    setUpAll(() {
      TestInjector.add<SharedData>(implementation: mockSharedData);
    });

    test('Logout com sucesso', () async {
      await usuarioStore.logout();

      expect(
        usuarioStore.state.runtimeType,
        SaiuSuccessState,
      );
    });

    test('Usuário logado', () async {
      when(mockSharedData.hasKey(Auth.KEY)).thenAnswer(
        (_) => Future.value(true),
      );
      when(mockSharedData.get(Auth.KEY)).thenAnswer(
        (_) => Future.value(authJsonDeTeste),
      );

      final auth = await usuarioStore.obterInfoUsuarioLogado();

      expect(
        auth,
        authDeTeste,
      );
    });
  });
}
