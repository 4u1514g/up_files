import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:up_files/account/login_screen.dart';
import 'helper/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
    child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingProvider()),
        ],child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);

    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitScreen(),
    );
  }
}
