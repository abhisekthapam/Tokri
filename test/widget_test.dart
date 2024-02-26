import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokri_sem_three/view/signup_page.dart';

void main() {
  testWidgets('SignupPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SignupPage(),
    ));

    expect(find.text('Create an Tokri Account'), findsOneWidget);
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Signup'), findsOneWidget);
    expect(find.text('Already have an account?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Abhisek');
    await tester.enterText(find.byType(TextField).at(1), 'Thapa');
    await tester.enterText(find.byType(TextField).at(2), 'Kerabari');
    await tester.enterText(find.byType(TextField).at(3), 'abhi@example.com');
    await tester.enterText(find.byType(TextField).at(4), '1234567890');
    await tester.enterText(find.byType(TextField).at(5), 'abhisek');

    await tester.tap(find.text('Signup'));
    await tester.pump();

  });
}
