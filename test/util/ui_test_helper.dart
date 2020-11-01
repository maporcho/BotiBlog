import 'package:boti_blog/common/infrastructure/logger.dart';
import 'package:boti_blog/common/ui/alerter.dart';
import 'package:boti_blog/common/ui/primary_button.dart';
import 'package:boti_blog/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util/dubles/alerter_mock.dart';
import '../util/dubles/fake_network_image_widget.dart';
import '../util/dubles/logger_mock.dart';
import 'test_injector.dart';

class UiTestHelper {
  static injectCommonUiDependencies() {
    TestInjector.add<Logger>(implementation: MockLogger());
    TestInjector.add<Alerter>(implementation: MockAlerter());
    TestInjector.add<NetworkImageWidget>(
        implementation: FakeNetworkImageWidget());
  }

  static Future<Null> pumpWithMaterial(
      WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(new MaterialApp(home: new Material(child: widget)));
    await tester.pump(Duration(seconds: 3));
  }

  /* Para ser usado quando Tester.tap não funcionar  (devido, por exemplo, ao 
  issue https://github.com/flutter/flutter/issues/31066)*/
  static tapPrimaryButton() {
    final elements = find.byType(PrimaryButton).evaluate();
    if (elements.length != 1) {
      throw Exception('Mais de um PrimaryButton encontrado!');
    }
    (elements.first.widget as PrimaryButton).onPressed();
  }
}
