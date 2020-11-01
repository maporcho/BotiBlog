import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/model/error.dart';
import 'package:flutter/foundation.dart';

abstract class PostsRequester {
  Future obterPosts({
    @required Function(List<Post>) onSuccess,
    @required Function(Error erro) onFail,
  });

  Future adicionarOuAtualizarPost({
    @required Post postNovoOuAtualizado,
    @required Function onSuccess,
    @required Function onFail,
  });

  Future remover({
    @required Post post,
    @required Function onSuccess,
    @required Function onFail,
  });
}
