import 'package:boti_blog/common/model/error.dart';

import 'base_state.dart';

class ErrorState extends BaseState {
  final Error erro;
  const ErrorState(this.erro);

  @override
  String toString() => erro.toString();
}
