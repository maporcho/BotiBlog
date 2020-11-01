import 'package:boti_blog/business/posts/store/posts_store.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/page/posts_page.dart';
import 'package:boti_blog/ui/widgets/post_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../util/dubles/page_router_mock.dart';
import '../util/dubles/store/posts_store_stub.dart';
import '../util/mass/post_test_mass.dart';
import '../util/test_injector.dart';
import '../util/ui_test_helper.dart';

final postsPage = PostsPage();

final mockPageRouter = MockPageRouter();

void main() {
  group('[PostsPage tests]', () {
    setUpAll(() {
      UiTestHelper.injectCommonUiDependencies();
      TestInjector.add<PostsStore>(
        implementation: PostsStoreStub(),
      );
      TestInjector.add<PageRouter>(implementation: mockPageRouter);
    });

    setUp(() {
      reset(mockPageRouter);
    });

    testWidgets('lista vazia', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          postsPage,
        );

        expect(find.text(Strings.postsListaVazia), findsOneWidget);
      });
    });

    testWidgets('lista com posts', (WidgetTester tester) async {
      TestInjector.add<PostsStore>(
        implementation: PostsStoreStub(
          posts: postsDeTeste,
        ),
      );

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          postsPage,
        );

        expect(
          find.byType(PostItem),
          findsNWidgets(
            postsDeTeste.length,
          ),
        );
      });
    });

    testWidgets('erro ao carregar lista com posts',
        (WidgetTester tester) async {
      TestInjector.add<PostsStore>(
        implementation: PostsStoreStub(
          obterPostsComSucesso: false,
        ),
      );

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          postsPage,
        );

        expect(find.text(Strings.postsErroAoCarregar), findsOneWidget);
      });
    });

    testWidgets('não faz nada ao tocar num post que não é do usuário',
        (WidgetTester tester) async {
      TestInjector.add<PostsStore>(
        implementation: PostsStoreStub(
          posts: [postDeTeste1],
          mockIdUsuarioLogado: postDeTeste1.user.id + 1,
        ),
      );

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          postsPage,
        );

        //ao tocar num post que *não* é de autoria do usuário...
        await tester.tap(find.byType(PostItem));

        //fica na mesma tela (nada acontece)
        verifyZeroInteractions(mockPageRouter);
      });
    });

    testWidgets(
        'vai pra tela de edição de post ao tocar num post que é do usuário',
        (WidgetTester tester) async {
      TestInjector.add<PostsStore>(
        implementation: PostsStoreStub(
          posts: [postDeTeste1],
          mockIdUsuarioLogado: postDeTeste1.user.id,
        ),
      );

      when(mockPageRouter.pushEditPost(any, any))
          .thenAnswer((_) => Future.value(false));

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          postsPage,
        );

        //ao tocar num post que é de autoria do usuário...
        await tester.tap(find.byType(PostItem));

        //...vai pra tela de edição de post
        verify(mockPageRouter.pushEditPost(any, postDeTeste1));
      });
    });
  });
}
