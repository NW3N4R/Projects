import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/gavenmodel.dart';
import 'package:garmian_house_of_charity/main.dart';
import 'package:intl/intl.dart' as intl;

late Gavenmodel gaven;

class GavenUpdateView extends StatelessWidget {
  final Gavenmodel _gavenmodel;
  GavenUpdateView(this._gavenmodel, {super.key}) {
    gaven = _gavenmodel;
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'خشتەی بەخشراو >> نوێکردنەوە',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl, // Set the text direction to RTL
        child: MainGavenUpdater(),
      ),
    );
  }
}

class MainGavenUpdater extends StatefulWidget {
  const MainGavenUpdater({
    super.key,
  });

  @override
  HomePage createState() => HomePage();
}

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

class HomePage extends State<MainGavenUpdater> {
  int delcount = 0;
  final nametxtcontroller = TextEditingController();
  final moneytxtcontroller = TextEditingController();
  final notetxtcontroller = TextEditingController();
  final addresstxtcontroller = TextEditingController();
  final phonetxtcontroller = TextEditingController();
  var monthtxtcontroller = TextEditingController();
  var daytxtcontroller = TextEditingController();

  Future<void> updateVoid(BuildContext context) async {
int? day = int.tryParse(daytxtcontroller.text);
    int? month = int.tryParse(monthtxtcontroller.text);

    if (day == null) {
      daytxtcontroller.text = intl.DateFormat("yyyy-MM-dd").parse(gaven.date).day.toString();
    }
    if (month == null) {
      monthtxtcontroller.text = intl.DateFormat("yyyy-MM-dd").parse(gaven.date).month.toString();
    }

    gaven.name = nametxtcontroller.text;
    gaven.money = moneytxtcontroller.text;
    gaven.note = notetxtcontroller.text;
    gaven.address = addresstxtcontroller.text;
    gaven.phone = phonetxtcontroller.text;
    gaven.date =
        '${selectedYear}-${monthtxtcontroller.text}-${daytxtcontroller.text}';
    bool isup = await ConfigureApi().put('GavenMoney/Update', gaven);
    if (isup) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('نوێ کرایەوە')),
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

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('دڵنیای لە سڕینەوەی ${gaven.name}؟'),
          content: Row(
            children: [
              TextButton(
                  onPressed: () => deleteVoid(dialogContext),
                  child: Text(
                    'بەڵێ بیسڕەوە',
                    style:
                        TextStyle(fontFamily: 'DroidArabic', color: Colors.red),
                  ))
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteVoid(BuildContext dialogContext) async {
    Navigator.pop(dialogContext);
    bool isdelete = await ConfigureApi().delete('GavenMoney/Delete', gaven.id);

    if (isdelete) {
      if (mounted) {
        MaterialPageRoute(
          builder: (context) => TabbedApp(
            initialIndex: 1,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nametxtcontroller.text = gaven.name;
    moneytxtcontroller.text = gaven.money;
    notetxtcontroller.text = gaven.note;
    addresstxtcontroller.text = gaven.address;
    phonetxtcontroller.text = gaven.note;
    DateTime parsedDate = intl.DateFormat("yyyy-MM-dd").parse(gaven.date);
    daytxtcontroller.text = parsedDate.day.toString();
    monthtxtcontroller.text = parsedDate.month.toString();
  }
  late int selectedYear = intl.DateFormat("yyyy-MM-dd").parse(gaven.date).year;

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
                'خشتەی بەخشراو >> نوێکردنەوە',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )),
        body: SingleChildScrollView(
          child: Container(
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
                        controller: phonetxtcontroller,
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
                                min: 1,
                                max: 31), // Set minimum and maximum values
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
                                min: 1,
                                max: 12), // Set minimum and maximum values
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
                        border:
                            Border.all(color: Colors.blue.shade200, width: 1),
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
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
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
                                      Icons.update,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      margin: const EdgeInsets.only(
                                          right: 15, left: 1),
                                      child: const Text(
                                        textAlign: TextAlign.center,
                                        'نوێکردنەوە',
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          ElevatedButton(
                            onPressed: () => _showPopup(context),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: Colors.red.shade500),
                            child: const Icon(
                              Icons.delete,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ]))
              ])),
        ));
  }
}
