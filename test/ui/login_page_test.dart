import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/ui/boti_flat_button.dart';
import 'package:boti_blog/common/ui/boti_text_form_field.dart';
import 'package:boti_blog/common/ui/primary_button.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/page/login_page.dart';
import 'package:boti_blog/ui/widgets/logo_header_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../util/dubles/page_router_mock.dart';
import '../util/dubles/store/usuario_store_stub.dart';
import '../util/test_injector.dart';
import '../util/ui_test_helper.dart';

final loginPage = LoginPage();

final mockPageRouter = MockPageRouter();

void main() {
  group('[LoginPage tests]', () {
    setUpAll(() {
      UiTestHelper.injectCommonUiDependencies();
      TestInjector.add<UsuarioStore>(implementation: UsuarioStoreStub());
      TestInjector.add<PageRouter>(implementation: mockPageRouter);
    });

    setUp(() {
      reset(mockPageRouter);
    });

    testWidgets('encontrar elementos da tela', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          loginPage,
        );

        expect(find.byType(LogoHeaderWidget), findsOneWidget);

        expect(find.widgetWithText(BotiTextFormField, Strings.emailLabel),
            findsOneWidget);
        expect(find.widgetWithText(BotiTextFormField, Strings.senhaLabel),
            findsOneWidget);
        expect(find.byType(PrimaryButton), findsOneWidget);
        expect(find.byType(BotiFlatButton), findsOneWidget);
      });
    });

    testWidgets('erros de validação ao tentar submeter formulário com erros',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          loginPage,
        );

        await tester.tap(find.byType(PrimaryButton));

        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text(Strings.senhaInvalida), findsOneWidget);
        expect(find.text(Strings.emailInvalido), findsOneWidget);

        verifyZeroInteractions(mockPageRouter);
      });
    });

    testWidgets('login com sucesso', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          loginPage,
        );

        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.emailLabel),
            'um-email@qualquer.com');
        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.senhaLabel),
            'UmaSenhaSuperSecreta');

        await tester.tap(find.byType(PrimaryButton));

        await tester.pump(const Duration(seconds: 3));

        verify(mockPageRouter.pushTabsPage(any));
      });
    });

    testWidgets('login com erro', (WidgetTester tester) async {
      TestInjector.add<UsuarioStore>(
          implementation: UsuarioStoreStub(
        loginComSucesso: false,
      ));

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          loginPage,
        );

        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.emailLabel),
            'um-email@qualquer.com');
        await tester.enterText(
            find.widgetWithText(BotiTextFormField, Strings.senhaLabel),
            'UmaSenhaSuperSecreta');

        await tester.tap(find.byType(PrimaryButton));

        await tester.pump(const Duration(seconds: 3));

        verifyZeroInteractions(mockPageRouter);
      });
    });
  });
}
