import 'package:boti_blog/business/novidades/state/novidades_state.dart';
import 'package:boti_blog/common/state/base_state.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/state/loading_state.dart';
import 'package:boti_blog/common/store/base_store.dart';
import 'package:boti_blog/infrastructure/novidades_requester.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'novidades_store.g.dart';

class NovidadesStore = _NovidadesStore with _$NovidadesStore;

abstract class _NovidadesStore extends BaseStore<BaseState> with Store {
  @observable
  BaseState state;

  @action
  obterNovidades() async {
    state = LoadingState();

    var requester = GetIt.instance.get<NovidadesRequester>();

    await requester.obterNovidades(onSuccess: (posts) {
      state = NovidadesCarregadasComSucessoState(posts);
    }, onFail: (erro) {
      state = ErrorState(erro);
    });
  }
}
