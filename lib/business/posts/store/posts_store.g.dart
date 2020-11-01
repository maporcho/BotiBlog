// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostsStore on _PostsStore, Store {
  final _$stateAtom = Atom(name: '_PostsStore.state');

  @override
  BaseState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(BaseState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$obterPostsAsyncAction = AsyncAction('_PostsStore.obterPosts');

  @override
  Future obterPosts() {
    return _$obterPostsAsyncAction.run(() => super.obterPosts());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
