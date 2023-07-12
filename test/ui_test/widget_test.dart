import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:simpleapp/provider/user_view_model.dart';
import 'package:simpleapp/views/first_screen.dart';
import 'package:simpleapp/views/second_screen.dart';
import 'package:simpleapp/views/third_screen.dart';

void main() {
  testWidgets('First Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => SelectedUser()),
        ],
        child: const MaterialApp(
          home: FirstScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 5));
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Palindrome'), findsOneWidget);
    expect(find.text('CHECK'), findsOneWidget);
    expect(find.text('NEXT'), findsOneWidget);
  });

  testWidgets('Second Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => SelectedUser()),
        ],
        child: const MaterialApp(
          home: SecondScreen(message: 'Johns'),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 5));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Second Screen'), findsOneWidget);
    expect(find.text('Welcome'), findsOneWidget);
  });

  testWidgets('Third Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => SelectedUser()),
        ],
        child: const MaterialApp(
          home: ThirdScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 5));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Third Screen'), findsOneWidget);
    // expect(find.byType(ListTile), findsOneWidget);
    // expect(find.byType(SpinKitCircle), findsOneWidget);
  });
}
