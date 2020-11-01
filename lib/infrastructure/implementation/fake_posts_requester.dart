import 'dart:convert';
import 'dart:math';

import 'package:boti_blog/infrastructure/posts_requester.dart';
import 'package:boti_blog/common/business/boti_blog_params.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/model/post.dart';
import 'package:boti_blog/common/model/error.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:lipsum/lipsum.dart' as lipsum;

class FakePostsRequester implements PostsRequester {
  static const String _POSTS_MOCK_KEY = "_POSTS_MOCK_KEY";
  final sharedData = GetIt.instance.get<SharedData>();

  @override
  Future obterPosts({
    @required Function(List<Post>) onSuccess,
    @required Function(Error erro) onFail,
  }) async {
    List<Post> posts = await _obterOuGerarPosts();
    onSuccess(posts);
  }

  Future adicionarOuAtualizarPost({
    @required Post postNovoOuAtualizado,
    @required Function onSuccess,
    @required Function onFail,
  }) async {
    List<Post> posts = await _obterPostsSalvos();
    var postASerAtualizado = posts.firstWhere(
      (p) => p.id == postNovoOuAtualizado.id,
      orElse: () => null,
    );
    if (postASerAtualizado == null) {
      _adicionarNovoPost(posts, postNovoOuAtualizado);
    } else {
      _atualizarPost(postASerAtualizado, postNovoOuAtualizado);
    }
    _salvarPosts(posts);
    onSuccess();
  }

  Future remover({
    @required Post post,
    @required Function onSuccess,
    @required Function onFail,
  }) async {
    List<Post> posts = await _obterPostsSalvos();
    posts.removeWhere((p) => p.id == post.id);
    _salvarPosts(posts);
    onSuccess();
  }

  _adicionarNovoPost(List<Post> posts, Post postNovo) {
    DateTime agora = DateTime.now();

    postNovo.id = agora.millisecondsSinceEpoch;
    postNovo.message.createdAt = agora;

    posts.add(postNovo);
  }

  _atualizarPost(Post postAntigo, Post postAtualizado) {
    postAntigo.message.content = postAtualizado.message.content;
    postAntigo.message.createdAt = DateTime.now();
  }

  Future<List<Post>> _obterOuGerarPosts() async {
    List<Post> posts = await _obterPostsSalvos();
    if ((posts ?? []).isEmpty) {
      posts = _gerarNPosts(30);
      _salvarPosts(posts);
    }

    posts.sort((a, b) => b.message.createdAt.compareTo(a.message.createdAt));

    await Future.delayed(
        Duration(
          seconds: Random().nextInt(2),
        ),
        () {});

    return posts;
  }

  Future<List<Post>> _obterPostsSalvos() async {
    String postsJson = await sharedData.get(_POSTS_MOCK_KEY);
    List<Post> posts = [];
    if (postsJson != null) {
      posts = (json.decode(postsJson) as List)
          .map((postJson) => Post.fromJson(postJson))
          .toList();
    }
    return posts;
  }

  List<Post> _gerarNPosts(int n) {
    final random = Random();

    List<Post> posts = [];

    for (int i = 0; i < n; i++) {
      final n = random.nextInt(20);
      posts.add(
        Post(
          id: i,
          message: Message(
            content: _cortarTextoSeNecessario(
                lipsum.createSentence(sentenceLength: 40 - n)),
            createdAt: DateTime.now().subtract(
              new Duration(days: n),
            ),
          ),
          user: User(
            id: i,
            name: lipsum.createWord(numWords: 2).replaceAll('.', ''),
            profilePicture:
                "https://robohash.org/set_set3/bgset_bg1/$i?size=50x50",
          ),
        ),
      );
    }

    return posts;
  }

  _cortarTextoSeNecessario(String texto) {
    return (texto.length > BotiBlogParams.MAX_CHARS_POST)
        ? texto.substring(0, BotiBlogParams.MAX_CHARS_POST)
        : texto;
  }

  _salvarPosts(List<Post> posts) {
    sharedData.add(_POSTS_MOCK_KEY, jsonEncode(posts));
  }
}
