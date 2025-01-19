import 'package:flutter/material.dart';
import 'package:latihankasirapp/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:latihankasirapp/pages/welcomepages.dart';
import 'package:latihankasirapp/service/supabase.dart';
// import 'package:latihankasirapp/pages/homepage.dart';

//untuk memanggil supabase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await InisialisasiSupabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}