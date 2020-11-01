import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/state/base_state.dart';

class PostsState extends BaseState {
  const PostsState();
}

class PostsCarregadosComSucessoState extends PostsState {
  final List<Post> posts;
  const PostsCarregadosComSucessoState(
    this.posts,
  );
}

class PostAdicionadoOuAlteradoComSucessoState extends PostsState {}
