import 'package:boti_blog/infrastructure/posts_requester.dart';
import 'package:boti_blog/business/posts/state/posts_state.dart';
import 'package:boti_blog/business/posts/store/posts_store.dart';
import 'package:boti_blog/business/usuario/model/auth.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
import 'package:mockito/mockito.dart';

import '../../../util/mass/auth_test_mass.dart';
import '../../../util/mass/post_test_mass.dart';
import '../../../util/dubles/requester/posts_requester_stub.dart';

import 'package:boti_blog/common/model/error.dart';

import '../../../util/dubles/shared_data_mock.dart';
import '../../../util/test_injector.dart';

final postsStore = PostsStore();

final mockSharedData = MockSharedData();

void main() {
  group('[PostsStore tests]', () {
    setUpAll(() {
      when(mockSharedData.get(Auth.KEY)).thenAnswer(
        (_) => Future.value(authJsonDeTeste),
      );

      TestInjector.add<SharedData>(implementation: mockSharedData);
    });

    test('Sucesso ao recuperar posts - lista vazia', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.success(
          posts: [],
        ),
      );

      await postsStore.obterPosts();

      expect(
        postsStore.state.runtimeType,
        PostsCarregadosComSucessoState,
      );

      expect((postsStore.state as PostsCarregadosComSucessoState).posts.isEmpty,
          true);
    });

    test('Sucesso ao recuperar posts - lista com posts', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.success(
          posts: postsDeTeste,
        ),
      );

      await postsStore.obterPosts();

      expect(
        postsStore.state.runtimeType,
        PostsCarregadosComSucessoState,
      );

      expect(
          ListEquality().equals(
            (postsStore.state as PostsCarregadosComSucessoState).posts,
            postsDeTeste,
          ),
          true);
    });

    test('Falha ao recuperar posts', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.fail(
          Error(
            message: 'Erro!',
          ),
        ),
      );

      await postsStore.obterPosts();

      expect(
        postsStore.state.runtimeType,
        ErrorState,
      );
    });

    test('Verificando que o post é do usuário logado', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.success(
          posts: postsDeTeste,
        ),
      );

      await postsStore.obterPosts();

      expect(
        postsStore.isPostDoUsuario(
          Post(
            id: 1,
            user: User(id: authDeTeste.id),
          ),
        ),
        true,
      );
    });

    int _idDiferenteDoUsuarioLogado() => authDeTeste.id + 1;

    test('Verificando que o post não é do usuário logado', () async {
      TestInjector.add<PostsRequester>(
        implementation: PostsRequesterStubBuilder.success(
          posts: postsDeTeste,
        ),
      );

      await postsStore.obterPosts();

      expect(
        postsStore.isPostDoUsuario(
          Post(
            id: 1,
            user: User(id: _idDiferenteDoUsuarioLogado()),
          ),
        ),
        false,
      );
    });
  });
}
