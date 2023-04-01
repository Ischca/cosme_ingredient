import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosme_ingredient/widgets/root_tab_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CosmeIngredientApp());
}

class CosmeIngredientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'コスメ成分評価',
      theme: CupertinoThemeData(
        primaryColor: Colors.purple,
      ),
      home: RootTabBar(),
      localizationsDelegates: [
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ja', 'JP'),
      ],
    );
  }
}
