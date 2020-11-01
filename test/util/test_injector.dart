import 'package:get_it/get_it.dart';

class TestInjector {
  static add<T>({dynamic implementation, T Function() factoryFunction}) {
    if ((implementation == null && factoryFunction == null) ||
        (implementation != null && factoryFunction != null)) {
      throw Exception(
          "Um e apenas um parâmetro deve ser fornecido: implementation ou factoryFunction");
    }

    if (GetIt.instance.isRegistered<T>()) {
      GetIt.instance.unregister<T>();
    }

    implementation != null
        ? GetIt.instance.registerLazySingleton<T>(() => implementation)
        : GetIt.instance.registerFactory<T>(factoryFunction);
  }
}
