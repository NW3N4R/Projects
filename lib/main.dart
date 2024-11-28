import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Views/gavenviews.dart';
import 'package:garmian_house_of_charity/Views/home.dart'; // Import your home page
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:garmian_house_of_charity/lockscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    showSemanticsDebugger: false,
    home: Lockscreen(), // Your initial screen
  ));
}

class TabbedApp extends StatefulWidget {
  final int initialIndex;

  const TabbedApp({super.key, required this.initialIndex});
  @override
  _TabbedAppState createState() => _TabbedAppState();
}

class _TabbedAppState extends State<TabbedApp> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap with MaterialApp
      debugShowCheckedModeBanner: false,
      locale: Locale('ar', 'IQ'), // Set the locale to Arabic (Iraq)
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', 'IQ'), // Arabic (Iraq)
      ],
      home: Scaffold(
        extendBodyBehindAppBar: true, // Body extends behind the status bar
        body: Container(
          color: Colors.white,
          child: selectedIndex == 0
              ? HomeView() // Show HomeView if selectedIndex is 0
              : GavenView(), // Show GavenHome for other tabs
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex, // Highlight the selected tab
          onTap: (int index) {
            setState(() {
              selectedIndex = index; // Update the selected tab
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'سەرەتا',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'بەخشراو',
            ),
          ],
        ),
      ),
    );
  }
}
