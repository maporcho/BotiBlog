import 'package:boti_blog/infrastructure/implementation/fake_usuario_requester.dart';
import 'package:boti_blog/infrastructure/usuario_requester.dart';
import 'package:boti_blog/business/usuario/store/usuario_store.dart';
import 'package:boti_blog/business/novidades/store/novidades_store.dart';
import 'package:boti_blog/business/posts/store/edit_posts_store.dart';
import 'package:boti_blog/business/posts/store/posts_store.dart';
import 'package:boti_blog/common/infrastructure/internet_connection_checker.dart';
import 'package:boti_blog/common/ui/implementation/page_router_navigator.dart';
import 'package:boti_blog/common/infrastructure/implementation/shared_data_preferences.dart';
import 'package:boti_blog/common/ui/page_router.dart';
import 'package:boti_blog/common/infrastructure/shared_data.dart';
import 'package:boti_blog/common/ui/dialog_presenter.dart';
import 'package:boti_blog/common/ui/implementation/awesome_dialog_presenter.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/colors.dart';
import 'package:boti_blog/ui/widgets/implementation/cached_network_image_widget.dart';
import 'package:boti_blog/ui/widgets/network_image_widget.dart';
import 'package:boti_blog/ui/widgets/page_container.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'infrastructure/implementation/fake_posts_requester.dart';
import 'infrastructure/implementation/novidades_http_requester.dart';
import 'infrastructure/novidades_requester.dart';
import 'infrastructure/posts_requester.dart';
import 'common/infrastructure/implementation/internet_connection_checker_connectivity.dart';
import 'common/infrastructure/implementation/logger_console.dart';
import 'common/infrastructure/logger.dart';
import 'common/store/destinations_store.dart';
import 'common/ui/alerter.dart';
import 'common/ui/implementation/alerter_flash.dart';

void main() {
  _injectCommonDependencies();

  _injectFactories();

  runApp(BotiBlogApp());
}

void _injectCommonDependencies() {
  GetIt getIt = GetIt.instance;

  getIt.registerLazySingleton<Logger>(() => LoggerConsole());
  getIt.registerLazySingleton<UsuarioRequester>(() => FakeUsuarioRequester());
  getIt.registerLazySingleton<NovidadesRequester>(
      () => NovidadesHttpRequester());

  getIt.registerLazySingleton<PostsRequester>(() => FakePostsRequester());

  getIt.registerLazySingleton<Alerter>(() => AlerterFlash());
  getIt.registerLazySingleton<DialogPresenter>(() => AwesomeDialogPresenter());
  getIt.registerLazySingleton<PageRouter>(() => PageRouterNavigator());
  getIt.registerLazySingleton<SharedData>(() => SharedDataPreferences());

  getIt.registerLazySingleton<DestinationsStore>(
    () => DestinationsStore().initialize(
      Destination.values,
      initialDestination: Destination.Novidades,
    ),
  );
  getIt.registerLazySingleton<UsuarioStore>(() => UsuarioStore());
  getIt.registerLazySingleton<NovidadesStore>(() => NovidadesStore());
  getIt.registerLazySingleton<PostsStore>(() => PostsStore());
  getIt.registerLazySingleton<EditPostsStore>(() => EditPostsStore());

  getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionCheckerConnectivity());
}

void _injectFactories() {
  GetIt getIt = GetIt.instance;

  getIt.registerFactory<NetworkImageWidget>(() => CachedNetworkImageWidget());
}

class BotiBlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        primaryColorDark: BotiBlogColors.oxleyDark,
        primaryColorLight: BotiBlogColors.oxleyLight,
        primaryColor: BotiBlogColors.oxleyDark,
        textTheme: Theme.of(context).textTheme.copyWith(
              headline1: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.w300,
                color: BotiBlogColors.oxleyDark,
              ),
              headline2: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.w300,
                color: BotiBlogColors.oxleyDark,
              ),
              caption: TextStyle(
                color: BotiBlogColors.silver,
              ),
            ),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              hintStyle: TextStyle(
                color: BotiBlogColors.silver,
              ),
              counterStyle: TextStyle(
                color: BotiBlogColors.oxleyDark,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: BotiBlogColors.oxleyLight,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: BotiBlogColors.oxleyLight,
                ),
              ),
            ),
        accentColor: BotiBlogColors.viridian,
        dividerColor: BotiBlogColors.silver,
      ),
      home: FutureBuilder<Widget>(
        future: GetIt.instance.get<PageRouter>().initialPage(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
