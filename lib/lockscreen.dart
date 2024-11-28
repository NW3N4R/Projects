// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/main.dart';



class Lockscreen extends StatefulWidget {
  const Lockscreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _lockscreen createState() => _lockscreen();
}

class _lockscreen extends State<Lockscreen> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  String? _errorText;
  TextEditingController _passcontroller = TextEditingController();

  void login(BuildContext context) async {
    bool isAuth = await ConfigureApi().Login(_passcontroller.text);
    if (isAuth) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TabbedApp(
            initialIndex: 0,
          ),
        ),
      );
    } else {
      setState(() {
        _errorText = 'وشەی نهێنی هەڵەیە';
      });
    }
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
          body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/mylogo.jpg',
                width: 140,
              ),
              Text(
                'ماڵی خێرخوازان و هەژارانی گەرمیان',
                style: TextStyle(fontFamily: 'DroidArabic', fontSize: 18),
              ),
              Text(
                'بەخێر بێن، تکایە وشەی نهێنی بنووسە',
                style: TextStyle(fontFamily: 'DroidArabic', fontSize: 15),
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  obscureText: true,
                  controller: _passcontroller,
                  decoration: InputDecoration(
                    hintText: 'وشەی نهێنی؟',
                    label: Text('وشەی نهێنی'),
                    errorText:   _errorText,
                    border: OutlineInputBorder(
                      // Default border
                      borderRadius: BorderRadius.circular(2), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Border when enabled
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 0.5), // Border color and width
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Border when focused
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                          color: Colors.green,
                          width: 1), // Focus border color and width
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => login(context),
                  child: Text(
                    'چوونە ژوورەوە',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'DroidArabic',
                    ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
