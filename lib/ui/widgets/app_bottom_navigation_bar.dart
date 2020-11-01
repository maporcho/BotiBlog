import 'package:boti_blog/common/store/destinations_store.dart';
import 'package:boti_blog/common/ui/strings.dart';
import 'package:boti_blog/ui/colors.dart';
import 'package:boti_blog/ui/widgets/page_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final DestinationsStore store;

  const AppBottomNavigationBar(this.store);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: const Key('bottomNavigationBar'),
      backgroundColor: BotiBlogColors.oxleyDark,
      selectedItemColor: BotiBlogColors.white,
      unselectedItemColor: BotiBlogColors.white.withAlpha(100),
      currentIndex: store.selectedDestinationIndex,
      items: store.destinations.map(
        (option) {
          switch (option) {
            case Destination.Novidades:
              return const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.newspaper),
                label: Strings.novidadesTabLabel,
              );
            case Destination.Posts:
              return const BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.commentAlt),
                  label: Strings.postsTabLabel);
            case Destination.Perfil:
              return const BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.user),
                  label: Strings.perfilTabLabel);
          }

          throw UnimplementedError('Unknow destination!');
        },
      ).toList(),
      onTap: (index) => store.selectDestination(index),
    );
  }
}
