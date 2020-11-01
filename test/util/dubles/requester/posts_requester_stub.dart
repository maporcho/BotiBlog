import 'package:boti_blog/infrastructure/posts_requester.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/model/error.dart';

class PostsRequesterStubBuilder {
  static PostsRequester success({List<Post> posts}) =>
      _PostsRequesterStubSuccess(posts: posts);
  static PostsRequester fail(Error erro) => _PostsRequesterStubFail(erro);
}

class _PostsRequesterStubSuccess implements PostsRequester {
  final List<Post> posts;

  _PostsRequesterStubSuccess({this.posts});

  @override
  Future obterPosts({
    Function(List<Post>) onSuccess,
    Function(Error erro) onFail,
  }) {
    onSuccess(posts);
  }

  @override
  Future adicionarOuAtualizarPost({
    Post postNovoOuAtualizado,
    Function onSuccess,
    Function onFail,
  }) {
    onSuccess();
  }

  @override
  Future remover({
    Post post,
    Function onSuccess,
    Function onFail,
  }) {
    onSuccess();
  }
}

class _PostsRequesterStubFail implements PostsRequester {
  final Error erro;

  _PostsRequesterStubFail(this.erro);

  @override
  Future obterPosts({
    Function(List<Post>) onSuccess,
    Function(Error erro) onFail,
  }) {
    onFail(erro);
  }

  @override
  Future adicionarOuAtualizarPost({
    Post postNovoOuAtualizado,
    Function onSuccess,
    Function onFail,
  }) {
    onFail(erro);
  }

  @override
  Future remover({
    Post post,
    Function onSuccess,
    Function onFail,
  }) {
    onFail(erro);
  }
}
