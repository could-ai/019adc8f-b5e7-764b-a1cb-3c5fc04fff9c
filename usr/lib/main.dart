import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/members_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/groups_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Grupos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/members': (context) => const MembersScreen(),
        '/attendance': (context) => const AttendanceScreen(),
        '/groups': (context) => const GroupsScreen(),
      },
    );
  }
}
