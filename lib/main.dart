import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sos/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  permissionSms();
  runApp(const MyApp());
}

void permissionSms() async {
  await [Permission.sms, Permission.location].request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SendMessageWidget(),
    );
  }
}
