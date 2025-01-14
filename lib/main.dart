import 'package:flutter/material.dart';
import 'package:latihan_responsi_plug_e/db/local.dart';
import 'package:latihan_responsi_plug_e/db/shared_preferences.dart';
import 'package:latihan_responsi_plug_e/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveToLocalDb.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
