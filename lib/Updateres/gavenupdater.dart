import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/gavenmodel.dart';
import 'package:garmian_house_of_charity/Views/gavenviews.dart';

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

class HomePage extends State<MainGavenUpdater> {
  int delcount = 0;
  final nametxtcontroller = TextEditingController();
  final moneytxtcontroller = TextEditingController();
  final notetxtcontroller = TextEditingController();
  final addresstxtcontroller = TextEditingController();
  final phonetxtcontroller = TextEditingController();
  DateTime _selectedDate = DateTime.parse(gaven.date);
  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          color: Colors.white,
          child: CupertinoDatePicker(
            initialDateTime: _selectedDate,
            mode: CupertinoDatePickerMode.date,
            minimumDate: DateTime(2000),
            maximumDate: DateTime(2100),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
        );
      },
    );
  }

  Future<void> updateVoid() async {
    gaven.name = nametxtcontroller.text;
    gaven.money = moneytxtcontroller.text;
    gaven.note = notetxtcontroller.text;
    gaven.address = addresstxtcontroller.text;
    gaven.phone = phonetxtcontroller.text;
    gaven.date =
        '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}';
    await ConfigureApi().put('GavenMoney/Update', gaven);
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
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const gavenViews()));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const gavenViews()));
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
                SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'بەروار',
                            style: TextStyle(fontFamily: 'DroidArabic'),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue.shade200, // Border color
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(3)),
                            child: TextButton(
                              onPressed: () => _showDatePicker(context),
                              child: Text(
                                '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
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
                                onPressed: () => updateVoid(),
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
