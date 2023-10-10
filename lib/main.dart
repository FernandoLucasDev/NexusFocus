import 'package:flutter/material.dart';
import 'package:nexus_focus/screens/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nexus_focus/screens/home_screen.dart';
import 'package:nexus_focus/screens/login_screen.dart';
import 'package:nexus_focus/screens/register_screen.dart';
import 'package:nexus_focus/screens/routine_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NexusFocus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => MainPage(),
        '/routines': (context) => RoutineScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Home(),
        ),
      ),
    );
  }
}
