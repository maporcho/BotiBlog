import 'package:boti_blog/business/novidades/state/novidades_state.dart';
import 'package:boti_blog/business/novidades/store/novidades_store.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/infrastructure/novidades_requester.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';

import '../../../util/mass/post_test_mass.dart';
import '../../../util/dubles/requester/novidades_requester_stub.dart';

import 'package:boti_blog/common/model/error.dart';

import '../../../util/test_injector.dart';

final novidadesStore = NovidadesStore();

void main() {
  group('NovidadesStore tests', () {
    test('Sucesso ao recuperar novidades - lista vazia', () async {
      TestInjector.add<NovidadesRequester>(
        implementation: NovidadesRequesterStubBuilder.success(
          [],
        ),
      );

      await novidadesStore.obterNovidades();

      expect(
        novidadesStore.state.runtimeType,
        NovidadesCarregadasComSucessoState,
      );

      expect(
          (novidadesStore.state as NovidadesCarregadasComSucessoState)
              .novidades
              .isEmpty,
          true);
    });

    test('Sucesso ao recuperar novidades - lista com novidades', () async {
      TestInjector.add<NovidadesRequester>(
        implementation: NovidadesRequesterStubBuilder.success(
          postsDeTeste,
        ),
      );

      await novidadesStore.obterNovidades();

      expect(
        novidadesStore.state.runtimeType,
        NovidadesCarregadasComSucessoState,
      );

      expect(
          ListEquality().equals(
            (novidadesStore.state as NovidadesCarregadasComSucessoState)
                .novidades,
            postsDeTeste,
          ),
          true);
    });

    test('Falha ao recuperar novidades', () async {
      TestInjector.add<NovidadesRequester>(
        implementation: NovidadesRequesterStubBuilder.fail(
          Error(
            message: 'Erro!',
          ),
        ),
      );

      await novidadesStore.obterNovidades();

      expect(
        novidadesStore.state.runtimeType,
        ErrorState,
      );
    });
  });
}
