import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tax/screens/splash_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await dotenv.load(fileName: ".env");

  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String anonKey = dotenv.get('ANON_KEY');

  await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 800),
    center: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  windowManager.setMinimumSize(const Size(1000, 800));

  runApp(const App());
}

// supabase instanceß
final supabase = Supabase.instance.client;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _TaxAppState();
}

class _TaxAppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
