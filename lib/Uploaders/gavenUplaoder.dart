import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/combinedGaven.dart';
import 'package:garmian_house_of_charity/Models/gavenautosets.dart';
import 'package:garmian_house_of_charity/Models/gavenmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:garmian_house_of_charity/Views/gavenviews.dart';
import 'package:garmian_house_of_charity/main.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart' as intl;

// ignore: must_be_immutable
class GavenUploaderView extends StatelessWidget {
  const GavenUploaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'خشتەی بەخشراو >> نوێکردنەوە',
      debugShowCheckedModeBanner: false,
      home: Directionality(
          textDirection: TextDirection.rtl, // Set the text direction to RTL
          child: MainGavenUploader()),
    );
  }
}

class MainGavenUploader extends StatefulWidget {
  const MainGavenUploader({
    super.key,
  });

  @override
  HomePage createState() => HomePage();
}

var nametxtcontroller = TextEditingController();
var moneytxtcontroller = TextEditingController();
var notetxtcontroller = TextEditingController();

var addresstxtcontroller = TextEditingController();
var phonenotxtcontroller = TextEditingController();

var monthtxtcontroller =
    TextEditingController(text: DateTime.now().month.toString());
var daytxtcontroller =
    TextEditingController(text: DateTime.now().day.toString());

class CustomRangeFormatter extends TextInputFormatter {
  final int min;
  final int max;

  CustomRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      // If the value is not within range, revert to the old value
      return oldValue;
    }

    // Otherwise, accept the new value
    return newValue;
  }
}

class HomePage extends State<MainGavenUploader> {
  int delcount = 0;
  DateTime now = DateTime.now();
  DateTime dt = DateTime.now();

  Future<void> updateVoid(BuildContext context) async {
int? day = int.tryParse(daytxtcontroller.text);
    int? month = int.tryParse(monthtxtcontroller.text);

    if (day == null) {
      daytxtcontroller.text = DateTime.now().day.toString();
    }
    if (month == null) {
      monthtxtcontroller.text = DateTime.now().month.toString();
    }
    Gavenmodel model = Gavenmodel(
        id: 0,
        name: nametxtcontroller.text,
        money: moneytxtcontroller.text,
        note: notetxtcontroller.text,
        phone: phonenotxtcontroller.text,
        address: addresstxtcontroller.text,
        date: '${selectedYear}-${monthtxtcontroller.text}-${daytxtcontroller.text}');

    String Aday = dt.weekday.toString();
    if (Aday == '1') {
      Aday = 'دوو شەممە';
    } else if (Aday == '2') {
      Aday = 'سێ شەممە';
    } else if (Aday == '3') {
      Aday = 'چوار شەممە';
    } else if (Aday == '4') {
      Aday = 'پێنج شەممە';
    } else if (Aday == '5') {
      Aday = 'هەیەنی';
    } else if (Aday == '6') {
      Aday = 'شەممە';
    } else if (Aday == '7') {
      Aday = ' شەممە';
    } 
  
    GavenAutoSet autoSet = GavenAutoSet(
        date: intl.DateFormat('yyyy-MM-dd').format(now),
        time: intl.DateFormat('HH:mm').format(now),
        day: Aday);
    Combinedgaven modelToSend =
        Combinedgaven(Gaven: model, AutoTimeSet: autoSet);
   
    bool isup = await ConfigureApi().post("GavenMoney/create", modelToSend);
    if (isup) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تۆمار کرا')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('کێشەیەک ڕوویدا دووبارە هەوڵبدەرەوە')),
        );
      }
    }
  }

  late int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year + 1;
    final int lastYear = currentYear - 1;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabbedApp(
                        initialIndex: 1,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward))
          ],
          title: Container(
            margin: const EdgeInsets.only(right: 1),
            alignment: Alignment.center,
            child: const Text(
              'خشتەی بەخشراو >> تۆمار کردن',
              style: TextStyle(fontSize: 18, fontFamily: 'DroidArabic'),
              textAlign: TextAlign.center,
            ),
          )),
      body: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
          child: Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  // width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: nametxtcontroller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade200)),
                        labelText: 'ناو',
                        hintText: 'ناو'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(4),
                  // width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: moneytxtcontroller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade200)),
                        labelText: 'بڕی پارە',
                        hintText: 'بڕی پارە'),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  // width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: notetxtcontroller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade200)),
                        labelText: 'تێبینی',
                        hintText: 'تێبینی'),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  // width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: addresstxtcontroller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade200)),
                        labelText: 'ناونیشان',
                        hintText: 'ناونیشان'),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  // width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: phonenotxtcontroller,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade200)),
                        labelText: 'ژمارە تەلەفون',
                        hintText: 'ژمارە تەلەفون'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    child: TextField(
                      controller: daytxtcontroller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only numeric characters
                        CustomRangeFormatter(
                            min: 1, max: 31), // Set minimum and maximum values
                      ],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 4, right: 4, top: 1, bottom: 1),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade300)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade200)),
                          labelText: 'ڕۆژ',
                          hintText: 'ڕۆژ'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    child: TextField(
                      controller: monthtxtcontroller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only numeric characters
                        CustomRangeFormatter(
                            min: 1, max: 12), // Set minimum and maximum values
                      ],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 4, right: 4, top: 1, bottom: 1),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade300)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade200)),
                          labelText: 'مانگ',
                          hintText: 'مانگ'),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade200, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.all(4),
                  child: DropdownButton(
                    value: selectedYear,
                    items: [
                      DropdownMenuItem(
                        value: currentYear - 1,
                        child: Text('${currentYear - 1}'),
                      ),
                      DropdownMenuItem(
                        value: currentYear,
                        child: Text('$currentYear'),
                      ),
                    ],
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedYear = newValue;
                        });
                      }
                    },
                    underline: SizedBox(),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => updateVoid(context),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.blue.shade500),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.upload,
                        size: 30,
                        color: Colors.white,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.8,
                        margin: const EdgeInsets.only(right: 15, left: 1),
                        child: const Text(
                          textAlign: TextAlign.center,
                          'تۆمار کردن',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontFamily: 'DroidArabic'),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            )
          ])),
    );
  }
}
