import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/home_screen.dart';
import 'package:sos/screens/get_started_screen.dart';
import 'package:sos/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  permissionSms();
  getLoginData();
  runApp(const MyApp());
}

void permissionSms() async {
  await [Permission.sms, Permission.location].request();
}

bool? isLogin;

void getLoginData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getBool("isLogin");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // Obtain shared preferences.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Flutter Sos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GetStartedScreen(),
    );
  }
}
