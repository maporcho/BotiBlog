import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/model/error.dart';
import 'package:flutter/foundation.dart';

abstract class NovidadesRequester {
  Future obterNovidades({
    @required Function(List<Post>) onSuccess,
    @required Function(Error erro) onFail,
  });
}
