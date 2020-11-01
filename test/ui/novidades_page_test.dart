import 'package:boti_blog/business/novidades/store/novidades_store.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/page/novidades_page.dart';
import 'package:boti_blog/ui/widgets/post_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util/dubles/store/novidades_store_stub.dart';
import '../util/mass/post_test_mass.dart';
import '../util/test_injector.dart';
import '../util/ui_test_helper.dart';

final novidadesPage = NovidadesPage();

void main() {
  group('[NovidadesPage tests]', () {
    setUpAll(() {
      UiTestHelper.injectCommonUiDependencies();
      TestInjector.add<NovidadesStore>(
        implementation: NovidadesStoreStub(),
      );
    });

    testWidgets('lista vazia', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          novidadesPage,
        );

        expect(find.text(Strings.novidadesListaVazia), findsOneWidget);
      });
    });

    testWidgets('lista com novidades', (WidgetTester tester) async {
      TestInjector.add<NovidadesStore>(
        implementation: NovidadesStoreStub(
          posts: postsDeTeste,
        ),
      );

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          novidadesPage,
        );

        expect(
          find.byType(PostItem),
          findsNWidgets(
            postsDeTeste.length,
          ),
        );
      });
    });

    testWidgets('erro ao carregar lista com novidades',
        (WidgetTester tester) async {
      TestInjector.add<NovidadesStore>(
        implementation: NovidadesStoreStub(
          obterNovidadesComSucesso: false,
        ),
      );

      await tester.runAsync(() async {
        await UiTestHelper.pumpWithMaterial(
          tester,
          novidadesPage,
        );

        expect(find.text(Strings.novidadesErroAoCarregar), findsOneWidget);
      });
    });
  });
}
