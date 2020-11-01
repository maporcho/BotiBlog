import 'package:boti_blog/business/posts/store/edit_posts_store.dart';
import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/ui/delete_button.dart';
import 'package:boti_blog/common/ui/dialog_presenter.dart';
import 'package:boti_blog/common/ui/implementation/awesome_dialog_presenter.dart';
import 'package:boti_blog/common/ui/primary_button.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/page/edit_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../util/dubles/store/edit_posts_store_mock.dart';
import '../util/dubles/store/edit_posts_store_stub.dart';
import '../util/mass/auth_test_mass.dart';
import '../util/dubles/fake_network_image_widget.dart';
import '../util/dubles/page_router_mock.dart';
import '../util/dubles/store/usuario_store_stub.dart';
import '../util/mass/post_test_mass.dart';
import '../util/test_injector.dart';
import '../util/ui_test_helper.dart';

var editPostPage = EditPostPage();

final mockPageRouter = MockPageRouter();

final mockEditPostsStore = MockEditPostsStore();

void main() {
  group('[EditPostPage tests]', () {
    setUpAll(() {
      UiTestHelper.injectCommonUiDependencies();

      TestInjector.add<UsuarioStore>(
          implementation: UsuarioStoreStub(
        auth: authDeTeste,
      ));
      TestInjector.add<PageRouter>(implementation: mockPageRouter);
      TestInjector.add<DialogPresenter>(
          implementation: AwesomeDialogPresenter());
    });

    setUp(() {
      TestInjector.add<EditPostsStore>(implementation: EditPostsStoreStub());

      reset(mockEditPostsStore);
      reset(mockPageRouter);
    });

    testWidgets('encontrar elementos da tela - novo post',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          editPostPage,
        );

        expect(find.byType(PrimaryButton), findsOneWidget);
        expect(find.byType(DeleteButton), findsNothing);
        expect(find.byType(FakeNetworkImageWidget), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
      });
    });

    testWidgets('encontrar elementos da tela - editando post',
        (WidgetTester tester) async {
      editPostPage = EditPostPage(
        post: postDeTeste1,
      );
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          editPostPage,
        );

        expect(find.byType(PrimaryButton), findsOneWidget);
        expect(find.byType(DeleteButton), findsOneWidget);
        expect(find.byType(FakeNetworkImageWidget), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
      });
    });

    testWidgets('erro de validação ao tentar adicionar post vazio',
        (WidgetTester tester) async {
      editPostPage = EditPostPage();
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          editPostPage,
        );

        UiTestHelper.tapPrimaryButton();

        await tester.pump(const Duration(seconds: 3));

        expect(find.text(Strings.postsErroVazio), findsOneWidget);
      });
    });

    testWidgets('sucesso ao adicionar novo post', (WidgetTester tester) async {
      editPostPage = EditPostPage();
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          editPostPage,
        );

        await tester.enterText(find.byType(TextFormField), 'teste');

        UiTestHelper.tapPrimaryButton();

        await tester.pump(const Duration(seconds: 3));

        verify(
          mockPageRouter.voltar(any, true),
        );
      });
    });

    testWidgets('falha ao adicionar novo post', (WidgetTester tester) async {
      editPostPage = EditPostPage();

      TestInjector.add<EditPostsStore>(
        implementation: EditPostsStoreStub(
          atualizarPostsComSucesso: false,
        ),
      );
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          editPostPage,
        );

        await tester.enterText(find.byType(TextFormField), 'teste');

        UiTestHelper.tapPrimaryButton();

        await tester.pump(const Duration(seconds: 3));

        verifyZeroInteractions(mockPageRouter);
      });
    });

    testWidgets('sucesso ao editar post', (WidgetTester tester) async {
      editPostPage = EditPostPage(
        post: postDeTeste1,
      );
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          editPostPage,
        );

        await tester.enterText(find.byType(TextFormField), 'teste');

        UiTestHelper.tapPrimaryButton();

        await tester.pump(const Duration(seconds: 3));

        verify(
          mockPageRouter.voltar(any, true),
        );
      });
    });

    testWidgets('tentando excluir post e desistindo em seguida',
        (WidgetTester tester) async {
      editPostPage = EditPostPage(
        post: postDeTeste1,
      );

      TestInjector.add<EditPostsStore>(implementation: mockEditPostsStore);

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          editPostPage,
        );

        await tester.tap(find.byType(DeleteButton));

        await tester.pump(const Duration(seconds: 3));

        //verificando se mostrou o dialog de confirmação
        expect(find.text(Strings.editarPostDialogConfirmacaoTitle),
            findsOneWidget);

        await tester.tap(
            find.text(Strings.editarPostDialogConfirmacaoBotaoCancelarLabel));

        //ao desistir de excluir, verificando que não houve interação com a store
        verifyNever(mockEditPostsStore.removerPost(any));
      });
    });

    testWidgets('excluindo post', (WidgetTester tester) async {
      editPostPage = EditPostPage(
        post: postDeTeste1,
      );

      TestInjector.add<EditPostsStore>(implementation: EditPostsStoreStub());

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          editPostPage,
        );

        await tester.tap(find.byType(DeleteButton));

        await tester.pump(const Duration(seconds: 3));

        //verificando se mostrou o dialog de confirmação
        expect(find.text(Strings.editarPostDialogConfirmacaoTitle),
            findsOneWidget);

        await tester.tap(
            find.text(Strings.editarPostDialogConfirmacaoBotaoConfirmarLabel));

        //verificando que voltou para a tela anterior
        verify(
          mockPageRouter.voltar(any, true),
        );
      });
    });

    //--------------------------------------------------------
  });
}
