import 'package:boti_blog/ui/colors.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../alerter.dart';

class AlerterFlash implements Alerter {
  showErrorAlert(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          position: FlashPosition.top,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.warning, color: Colors.red[300]),
            leftBarIndicatorColor: Colors.red[300],
          ),
        );
      },
    );
  }

  showSuccessAlert(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          position: FlashPosition.top,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title,
                    style: _titleStyle(
                      context,
                      Colors.white,
                    )),
            message: Text(message,
                style: _contentStyle(
                  context,
                  Colors.white,
                )),
            icon: Icon(
              Icons.check_circle,
              color: BotiBlogColors.oxleyDark,
            ),
            leftBarIndicatorColor: BotiBlogColors.vistaBlue,
          ),
        );
      },
    );
  }

  _titleStyle(BuildContext context, [Color color]) {
    var theme = Theme.of(context);
    return (theme.dialogTheme?.titleTextStyle ?? theme.textTheme.headline6)
        .copyWith(color: color);
  }

  _contentStyle(BuildContext context, [Color color]) {
    var theme = Theme.of(context);
    return (theme.dialogTheme?.contentTextStyle ?? theme.textTheme.bodyText2)
        .copyWith(color: color);
  }
}
