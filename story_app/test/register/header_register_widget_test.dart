import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:story_app/presentation/screens/user/register/widget/header_register_widget.dart';

void main() {
  testWidgets('HeaderRegisterWidget UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: HeaderRegisterWidget(),
      ),
    ));

    expect(find.byType(Image), findsOneWidget);

    final Finder imageFinder = find.byType(Image);
    expect(tester.getSize(imageFinder).width, 200);
    expect(tester.getSize(imageFinder).height, 200);
  });
}
