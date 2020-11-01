import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/ui/boti_text_form_field.dart';
import 'package:boti_blog/common/ui/dialog_presenter.dart';
import 'package:boti_blog/common/ui/implementation/awesome_dialog_presenter.dart';
import 'package:boti_blog/common/ui/primary_button.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/page/cadastro_page.dart';
import 'package:boti_blog/ui/widgets/logo_header_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../util/dubles/page_router_mock.dart';
import '../util/dubles/store/usuario_store_stub.dart';
import '../util/test_injector.dart';
import '../util/ui_test_helper.dart';

final cadastroPage = CadastroPage();

final mockPageRouter = MockPageRouter();

void main() {
  group('[CadastroPage tests]', () {
    setUpAll(() {
      UiTestHelper.injectCommonUiDependencies();
      TestInjector.add<UsuarioStore>(implementation: UsuarioStoreStub());
      TestInjector.add<PageRouter>(implementation: mockPageRouter);
      TestInjector.add<DialogPresenter>(
          implementation: AwesomeDialogPresenter());
    });

    setUp(() {
      reset(mockPageRouter);
    });

    testWidgets('encontrar elementos da tela', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          cadastroPage,
        );

        expect(find.byType(LogoHeaderWidget), findsOneWidget);

        expect(find.widgetWithText(BotiTextFormField, Strings.nomeLabel),
            findsOneWidget);
        expect(find.widgetWithText(BotiTextFormField, Strings.emailLabel),
            findsOneWidget);
        expect(find.widgetWithText(BotiTextFormField, Strings.senhaLabel),
            findsOneWidget);
        expect(find.byType(PrimaryButton), findsOneWidget);
      });
    });

    testWidgets('erros de validação ao tentar submeter formulário com erros',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          cadastroPage,
        );

        UiTestHelper.tapPrimaryButton();

        await tester.pump(const Duration(seconds: 3));

        expect(find.text(Strings.nomeInvalido), findsOneWidget);
        expect(find.text(Strings.senhaInvalida), findsOneWidget);
        expect(find.text(Strings.emailInvalido), findsOneWidget);

        verifyZeroInteractions(mockPageRouter);
      });
    });

    testWidgets('cadastro com sucesso', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          cadastroPage,
        );

        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.nomeLabel),
            'Belatrano da Silva');

        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.emailLabel),
            'um-email@qualquer.com');

        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.senhaLabel),
            'UmaSenhaSuperSecreta');

        UiTestHelper.tapPrimaryButton();

        await tester.pump(const Duration(seconds: 3));

        //verificando se exibiu dialogs
        expect(
          find.text(Strings.cadastroSucessoTitulo),
          findsOneWidget,
        );

        //tocando no botão do dialog
        await tester.tap(find.text(Strings.cadastroSucessoBotaoOkLabel));

        await tester.pump(Duration(seconds: 3));

        //verificando se volta para a tela anterior
        verify(mockPageRouter.pushLoginPage(any));
      });
    });

    testWidgets('cadastro com erro', (WidgetTester tester) async {
      TestInjector.add<UsuarioStore>(
          implementation: UsuarioStoreStub(
        cadastroComSucesso: false,
      ));

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          cadastroPage,
        );

        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.nomeLabel),
            'Belatrano da Silva');

        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.emailLabel),
            'um-email@qualquer.com');

        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.senhaLabel),
            'UmaSenhaSuperSecreta');

        UiTestHelper.tapPrimaryButton();

        await tester.pump(const Duration(seconds: 3));

        //verificando se não exibiu dialog de sucesso e se ficou na mesma tela
        expect(
          find.text(Strings.cadastroSucessoTitulo),
          findsNothing,
        );
        verifyZeroInteractions(mockPageRouter);
      });
    });
  });
}
