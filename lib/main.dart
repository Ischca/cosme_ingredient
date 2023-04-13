import 'package:cosme_ingredient/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosme_ingredient/widgets/root_tab_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'config/data_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
        providers: [
          Provider<DataCache>(create: (_) => DataCache()),
          Provider<FirestoreService>(create: (context) => FirestoreService(context)),
        ],
        child: CosmeIngredientApp(),
      )
  );
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
