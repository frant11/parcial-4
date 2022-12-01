import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parcial4_dif/paginas/principal.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Parcial4());
}

class Parcial4 extends StatelessWidget {
  const Parcial4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parcial 4',
      theme: ThemeData(backgroundColor: Colors.white),
      home: Principal(),
    );
  }
}
