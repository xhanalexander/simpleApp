import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleapp/provider/user_view_model.dart';
import 'package:simpleapp/views/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => SelectedUser()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        debugShowCheckedModeBanner: false,
        home: const FirstScreen(),
      ),
    );
  }
}
