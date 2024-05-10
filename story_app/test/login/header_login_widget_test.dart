import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:story_app/presentation/screens/user/login/widget/header_login_widget.dart';

void main() {
  testWidgets('HeaderLoginWidget UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: HeaderLoginWidget(),
      ),
    ));

    expect(find.byType(Image), findsOneWidget);
    expect(find.text("Login to share your story..."), findsOneWidget);


    final Finder imageFinder = find.byType(Image);
    expect(tester.getSize(imageFinder).width, 200);
    expect(tester.getSize(imageFinder).height, 200);
  });
}
