import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/store/destinations_store.dart';
import 'package:boti_blog/common/ui/dialog_presenter.dart';
import 'package:boti_blog/common/ui/implementation/awesome_dialog_presenter.dart';
import 'package:boti_blog/common/ui/primary_button.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/page/perfil_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../util/mass/auth_test_mass.dart';
import '../util/dubles/fake_network_image_widget.dart';
import '../util/dubles/page_router_mock.dart';
import '../util/dubles/store/destination_store_mock.dart';
import '../util/dubles/store/usuario_store_stub.dart';
import '../util/test_injector.dart';
import '../util/ui_test_helper.dart';

final perfilPage = PerfilPage();

final mockPageRouter = MockPageRouter();

final mockDestinationsStore = MockDestinationsStore();

void main() {
  group('[PerfilPage tests]', () {
    setUpAll(() {
      UiTestHelper.injectCommonUiDependencies();
      TestInjector.add<UsuarioStore>(
          implementation: UsuarioStoreStub(
        auth: authDeTeste,
      ));
      TestInjector.add<PageRouter>(implementation: mockPageRouter);
      TestInjector.add<DestinationsStore>(
          implementation: mockDestinationsStore);
      TestInjector.add<DialogPresenter>(
          implementation: AwesomeDialogPresenter());
    });

    testWidgets('encontrar elementos da tela', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          perfilPage,
        );

        expect(find.byType(FakeNetworkImageWidget), findsOneWidget);
        expect(find.text(authDeTeste.nome), findsOneWidget);
        expect(
          find.widgetWithText(PrimaryButton, Strings.perfilBotaoSairLabel),
          findsOneWidget,
        );
      });
    });

    testWidgets('exibindo dialog de confirmação ao tocar no botão de logout',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          perfilPage,
        );

        //tocando no botão para sair
        await tester.tap(
            find.widgetWithText(PrimaryButton, Strings.perfilBotaoSairLabel));

        await tester.pump(Duration(seconds: 3));

        //verificando se exibiu dialog
        expect(find.text(Strings.perfilDialogSairTitle), findsOneWidget);

        await tester.tap(find.text(Strings.perfilDialogSairBotaoOkLabel));

        await tester.pump(Duration(seconds: 3));

        //verificando se vai para tela de login ao confirmar logout
        verify(mockPageRouter.pushLoginPage(any));
        verify(mockDestinationsStore.reset());
      });
    });
  });
}
