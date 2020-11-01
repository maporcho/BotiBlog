import 'package:boti_blog/business/novidades/state/novidades_state.dart';
import 'package:boti_blog/business/novidades/store/novidades_store.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/error_state.dart';
import 'package:boti_blog/common/model/error.dart';

class NovidadesStoreStub extends NovidadesStore {
  final List<Post> posts;
  final bool obterNovidadesComSucesso;

  NovidadesStoreStub({
    this.posts,
    this.obterNovidadesComSucesso = true,
  });

  @override
  Future obterNovidades() {
    state = obterNovidadesComSucesso
        ? NovidadesCarregadasComSucessoState(posts ?? [])
        : ErrorState(
            Error(message: 'Erro'),
          );
  }
}
