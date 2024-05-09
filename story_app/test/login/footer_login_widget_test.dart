import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:story_app/presentation/screens/user/login/widget/footer_login_widget.dart';
import 'package:story_app/utils/constant/name_routes.dart';

void main() {
  testWidgets('FooterLoginWidget UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const Scaffold(
        body: FooterLoginWidget(),
      ),
      routes: {
        NameRoutes.registerPageRoute: (context) => const Scaffold(),
      },
    ));

    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text("Register"), findsOneWidget);

    await tester.tap(find.text("Register"));
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
