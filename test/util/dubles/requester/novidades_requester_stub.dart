import 'package:boti_blog/common/model/error.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/infrastructure/novidades_requester.dart';

class NovidadesRequesterStubBuilder {
  static NovidadesRequester success(List<Post> posts) =>
      _NovidadesRequesterStubSuccess(posts);
  static NovidadesRequester fail(Error erro) =>
      _NovidadesRequesterStubFail(erro);
}

class _NovidadesRequesterStubSuccess implements NovidadesRequester {
  final List<Post> posts;

  _NovidadesRequesterStubSuccess(this.posts);

  @override
  Future obterNovidades({
    Function(List<Post>) onSuccess,
    Function(Error erro) onFail,
  }) {
    onSuccess(posts);
  }
}

class _NovidadesRequesterStubFail implements NovidadesRequester {
  final Error erro;

  _NovidadesRequesterStubFail(this.erro);

  @override
  Future obterNovidades({
    Function(List<Post>) onSuccess,
    Function(Error erro) onFail,
  }) {
    onFail(erro);
  }
}
