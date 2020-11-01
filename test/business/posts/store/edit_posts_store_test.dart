import 'package:boti_blog/infrastructure/posts_requester.dart';
import 'package:boti_blog/business/posts/state/posts_state.dart';
import 'package:boti_blog/business/posts/store/edit_posts_store.dart';
import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../util/mass/auth_test_mass.dart';
import '../../../util/mass/post_test_mass.dart';
import '../../../util/dubles/requester/posts_requester_stub.dart';

import 'package:boti_blog/common/model/error.dart';

import '../../../util/dubles/shared_data_mock.dart';
import '../../../util/test_injector.dart';

final editPostsStore = EditPostsStore();

final mockSharedData = MockSharedData();

void main() {
  _inicializarMockSharedDataComDadosdeAutenticacao() {
    when(mockSharedData.get(Auth.KEY)).thenAnswer(
      (_) => Future.value(authJsonDeTeste),
    );
    when(mockSharedData.hasKey(Auth.KEY)).thenAnswer(
      (_) => Future.value(true),
    );
  }

  group('[EditPostsStore tests - adicionar/atualizar post]', () {
    setUpAll(() {
      _inicializarMockSharedDataComDadosdeAutenticacao();
      TestInjector.add<SharedData>(implementation: mockSharedData);
      TestInjector.add<UsuarioStore>(implementation: UsuarioStore());
    });

    test('Sucesso ao adicionar posts', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.success(),
      );

      await editPostsStore.adicionarOuAtualizarPost('novo post');

      expect(
        editPostsStore.state.runtimeType,
        PostAdicionadoOuAlteradoComSucessoState,
      );
    });

    test('Falha ao adicionar posts', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.fail(
          Error(message: 'erro'),
        ),
      );

      await editPostsStore.adicionarOuAtualizarPost('novo post');

      expect(
        editPostsStore.state.runtimeType,
        ErrorState,
      );
    });

    test('Sucesso ao atualizar posts', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.success(),
      );

      final String conteudo = "${DateTime.now().millisecondsSinceEpoch}";

      await editPostsStore.adicionarOuAtualizarPost(
        conteudo,
        postAAtualizar: postDeTeste1,
      );

      expect(
        editPostsStore.state.runtimeType,
        PostAdicionadoOuAlteradoComSucessoState,
      );

      expect(
        postDeTeste1.message.content,
        conteudo,
      );
    });

    test('Falha ao atualizar posts', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.fail(
          Error(message: 'erro'),
        ),
      );

      await editPostsStore.adicionarOuAtualizarPost('novo post');

      final String conteudoNovo = "${DateTime.now().millisecondsSinceEpoch}";

      await editPostsStore.adicionarOuAtualizarPost(
        conteudoNovo,
        postAAtualizar: postDeTeste1,
      );

      expect(
        editPostsStore.state.runtimeType,
        ErrorState,
      );
    });
  });

  group('[EditPostsStore tests - remover post]', () {
    setUpAll(() {
      _inicializarMockSharedDataComDadosdeAutenticacao();
      TestInjector.add<SharedData>(implementation: mockSharedData);
      TestInjector.add<UsuarioStore>(implementation: UsuarioStore());
    });

    test('Sucesso ao remover posts', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.success(),
      );

      await editPostsStore.removerPost(postDeTeste1);

      expect(
        editPostsStore.state.runtimeType,
        PostAdicionadoOuAlteradoComSucessoState,
      );
    });

    test('Falha ao adicionar posts', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.fail(
          Error(message: 'erro'),
        ),
      );

      await editPostsStore.removerPost(postDeTeste1);

      expect(
        editPostsStore.state.runtimeType,
        ErrorState,
      );
    });
  });
}
