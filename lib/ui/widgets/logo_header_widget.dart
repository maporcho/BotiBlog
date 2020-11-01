import 'package:boti_blog/common/ui/strings.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class LogoHeaderWidget extends StatelessWidget {
  final bool mostrarBotaoVoltar;
  final String texto;

  const LogoHeaderWidget({
    this.mostrarBotaoVoltar = false,
    this.texto,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              if (mostrarBotaoVoltar ?? false)
                BackButton(
                  color: BotiBlogColors.oxleyDark,
                ),
              Expanded(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
              ),
              if (mostrarBotaoVoltar ?? false)
                SizedBox(
                  width: 48.0,
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              Strings.appName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          if ((texto ?? '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                texto,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 16.0,
                    ),
              ),
            )
        ],
      );
}
