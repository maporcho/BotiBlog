import 'package:boti_blog/common/store/destinations_store.dart';
import 'package:boti_blog/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:boti_blog/ui/widgets/page_container.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TabsPage extends StatelessWidget {
  static String tag = 'tabs-page';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    final GlobalKey<State> _observerKey = new GlobalKey<State>();

    DestinationsStore store = GetIt.instance.get<DestinationsStore>();

    return Observer(
      key: _observerKey,
      builder: (_) {
        return Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: PageContainer(
              store.selectedDestination,
            ),
          ),
          bottomNavigationBar: AppBottomNavigationBar(store),
        );
      },
    );
  }
}
