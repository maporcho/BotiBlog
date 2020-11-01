// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_posts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditPostsStore on _EditPostsStore, Store {
  final _$stateAtom = Atom(name: '_EditPostsStore.state');

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

  final _$adicionarOuAtualizarPostAsyncAction =
      AsyncAction('_EditPostsStore.adicionarOuAtualizarPost');

  @override
  Future adicionarOuAtualizarPost(String content, {Post postAAtualizar}) {
    return _$adicionarOuAtualizarPostAsyncAction.run(() => super
        .adicionarOuAtualizarPost(content, postAAtualizar: postAAtualizar));
  }

  final _$removerPostAsyncAction = AsyncAction('_EditPostsStore.removerPost');

  @override
  Future removerPost(Post post) {
    return _$removerPostAsyncAction.run(() => super.removerPost(post));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
