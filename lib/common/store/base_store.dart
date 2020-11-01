import 'package:boti_blog/common/state/base_state.dart';

abstract class BaseStore<T extends BaseState> {
  T get state;

  set state(T state);

  resetStore() {
    state = null;
  }
}
