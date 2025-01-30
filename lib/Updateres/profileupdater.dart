import 'dart:async';
import 'package:flutter/material.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/donatedprofilesmodel.dart';
import 'package:garmian_house_of_charity/main.dart';

late Donatedprofilesmodel gaven;

class ProfileUpdateView extends StatelessWidget {
  final Donatedprofilesmodel _gavenmodel;
  ProfileUpdateView(this._gavenmodel, {super.key}) {
    gaven = _gavenmodel;
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl, // Set the text direction to RTL
        child: MainProfileUpdater(),
      ),
    );
  }
}

class MainProfileUpdater extends StatefulWidget {
  const MainProfileUpdater({
    super.key,
  });

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MainProfileUpdater> {
  final nametxtcontroller = TextEditingController();
  final addresstxtcontroller = TextEditingController();
  final phonetxtcontroller = TextEditingController();

  Future<void> updateVoid(BuildContext context) async {
    setState(() {
      gaven.Name = nametxtcontroller.text;
      gaven.Address = addresstxtcontroller.text;
      gaven.Phone = phonetxtcontroller.text;
    });
    bool isup = await ConfigureApi().put("donation/put", gaven);
    if (isup) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('نوێکردنەوە سەرکەوتوو بوو')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('کێشەیەک ڕوویدا دووبارە هەوڵبدەرەوە')),
        );
      }
    }
    debugPrint(gaven.Name);
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'دڵنیای لە سڕینەوەی ${gaven.Name}؟',
              ),
              content: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Text(
                          'سڕینەوەی ئەم ناوە ئەبێتە هۆی سڕینەوەی تەواوی بەخشینەکانی و ناتوانی پاشەگەز ببیتەوە لەم کردارە'),
                      TextButton(
                          onPressed: () => deleteVoid(dialogContext),
                          child: Text(
                            'بەڵێ بیسڕەوە',
                            style: TextStyle(
                                fontFamily: 'DroidArabic', color: Colors.red),
                          ))
                    ],
                  )),
            ));
      },
    );
  }

  Future<void> deleteVoid(BuildContext dialogContext) async {
    Navigator.pop(dialogContext);
    bool isdelete = await ConfigureApi().delete('donation/Delete', gaven.id);

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
    nametxtcontroller.text = gaven.Name;
    addresstxtcontroller.text = gaven.Address;
    phonetxtcontroller.text = gaven.Phone;
    debugPrint('id is ${gaven.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: TextField(
                    keyboardType: TextInputType.text,
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
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
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
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                        child: ElevatedButton(
                      onPressed: () => updateVoid(context),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.blue.shade500),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5, left: 1),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'نوێکردنەوە',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                          backgroundColor: Colors.white),
                      child: const Icon(
                        Icons.delete,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ])),
    );
  }
}
