import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/base_state.dart';

class NovidadesState extends BaseState {
  const NovidadesState();
}

class NovidadesCarregadasComSucessoState extends NovidadesState {
  final List<Post> novidades;
  const NovidadesCarregadasComSucessoState(
    this.novidades,
  );
}
