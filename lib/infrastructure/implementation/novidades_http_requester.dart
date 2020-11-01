import 'dart:convert';

import 'package:boti_blog/common/infrastructure/internet_connection_checker.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/model/error.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/infrastructure/novidades_requester.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;

class NovidadesHttpRequester implements NovidadesRequester {
  @override
  Future obterNovidades({
    @required Function(List<Post>) onSuccess,
    @required Function(Error erro) onFail,
  }) async {
    if (!(await GetIt.instance
        .get<InternetConnectionChecker>()
        .isConnected())) {
      onFail(Error(message: Strings.semConexao));
      return;
    }

    final response = await http
        .get('https://gb-mobile-app-teste.s3.amazonaws.com/data.json');

    if (response.statusCode == 200) {
      final parsed = jsonDecode(utf8.decode(response.bodyBytes))['news'];
      final novidades =
          parsed.map<Post>((json) => Post.fromJson(json)).toList();
      onSuccess(novidades);
    } else {
      onFail(Error(message: Strings.erroInesperado));
    }
  }
}
