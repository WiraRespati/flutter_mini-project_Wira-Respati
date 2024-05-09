import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:story_app/presentation/screens/user/register/widget/footer_register_widget.dart';
import 'package:story_app/utils/constant/name_routes.dart';

void main() {
  testWidgets('FooterRegisterWidget UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const Scaffold(
        body: FooterRegisterWidget(),
      ),
      routes: {
        NameRoutes.loginPageRoute: (context) => const Scaffold(),
      },
    ));

    expect(find.text("Already have an account?"), findsOneWidget);
    expect(find.text("Login"), findsOneWidget);

    await tester.tap(find.text("Login"));
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
