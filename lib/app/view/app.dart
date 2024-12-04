import 'package:flutter/material.dart';
import 'package:location_screen/attendence_store/views/home_view.dart';
import 'package:location_screen/l10n/l10n.dart';
import 'package:location_screen/themes/styles.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: Styles.lightColorScheme,
      ),
       darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: Styles.darkColorScheme,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeView(),
    );
  }
}
