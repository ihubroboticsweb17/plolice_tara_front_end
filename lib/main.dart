import 'package:edu_tara/features/complaint_screen/controller/complaint_controller.dart';
import 'package:edu_tara/features/language/controller/language_controller.dart';
import 'package:edu_tara/features/login/controller/login_controller.dart';
import 'package:edu_tara/features/welcome/controller/battery_controller.dart';
import 'package:edu_tara/features/welcome/controller/volume_controller.dart';
import 'package:edu_tara/features/welcome/view/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// git remote set-url origin https://github.com/Muneef-Nk/tara_gen_1.git

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => VolumeController()),
        ChangeNotifierProvider(create: (_) => BatteryProvider()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => ComplaintController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
