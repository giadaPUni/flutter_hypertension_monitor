import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hypertension_monitor/main.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart';


void main() {

  testWidgets(
    'Application starts correctly',
    (WidgetTester tester) async {

      await tester.pumpWidget(

        HypertensionMonitorApp(

          initialRoute: AppRoutes.login,

        ),

      );


      await tester.pump();


      expect(
        find.byType(HypertensionMonitorApp),
        findsOneWidget,
      );

    },
  );

}