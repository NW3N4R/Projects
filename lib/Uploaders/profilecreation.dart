import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/autotimesetmodel.dart';
import 'package:garmian_house_of_charity/Models/donatedprofilesmodel.dart';
import 'package:garmian_house_of_charity/Models/donationhistorymodel.dart';
import 'package:garmian_house_of_charity/Models/profilecombinedmodel.dart';
import 'package:garmian_house_of_charity/main.dart';

// ignore: must_be_immutable
class ProfileCreationView extends StatelessWidget {
  const ProfileCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'خشتەی بەخشراو >> نوێکردنەوە',
      debugShowCheckedModeBanner: false,
      home: Directionality(
          textDirection: TextDirection.rtl, // Set the text direction to RTL
          child: MainProfileCreation()),
    );
  }
}

class MainProfileCreation extends StatefulWidget {
  const MainProfileCreation({
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
      return oldValue;
    }
    return newValue;
  }
}

class HomePage extends State<MainProfileCreation> {
  DateTime now = DateTime.now();
  late int selectedYear = now.year;
  double defaultMargin = 10;
  Future<void> updateVoid(BuildContext context) async {
    DateTime givingDate = DateTime(selectedYear,
        int.parse(monthtxtcontroller.text), int.parse(daytxtcontroller.text));
    Donatedprofilesmodel profile = Donatedprofilesmodel(
        id: 0,
        Name: nametxtcontroller.text,
        Address: addresstxtcontroller.text,
        Phone: phonenotxtcontroller.text);
    DonationHistoryModel historyModel = DonationHistoryModel(
        id: 0,
        amount: moneytxtcontroller.text.isEmpty
            ? 0
            : double.parse(moneytxtcontroller.text),
        note: notetxtcontroller.text,
        givingDate: givingDate,
        pid: 0);
    AutoTimeSetsModel timeSetsModel =
        AutoTimeSetsModel(id: 0, pid: 0, autoDate: DateTime.now());
    ProfileCombinedModel model = ProfileCombinedModel(
        donatedProfiles: profile,
        donationHistory: historyModel,
        autoTimeSets: timeSetsModel);

    String isup = await ConfigureApi().post("donation/Post", model);
    if (isup != '-') {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تۆمار کرا')),
        );
      }
    } else {
      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('کێشەیەک ڕوویدا دووبارە هەوڵبدەرەوە')),
        );
      }
    }
  }

  void checkPhone(String value) {
    final list = ConfigureApi.mainProfilesList;

    final isprofile = list?.any((x) => x.Phone == value);
    if (isprofile == true) {
      final profile = list?.firstWhere((x) => x.Phone == value);
      nametxtcontroller.text = profile!.Name;
      addresstxtcontroller.text = profile.Address;
    } else {
      debugPrint('no profile ${list!.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year + 1;

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
                  margin: const EdgeInsets.only(
                      top: 50, bottom: 50, left: 4, right: 4),
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
                    onChanged: (value) {
                      checkPhone(value);
                    },
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
            Container(
                margin: EdgeInsets.only(top: 50),
                child: Row(
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                ))
          ])),
    );
  }
}
