import 'package:flutter/material.dart';
import 'package:garmian_house_of_charity/Helpers/homeHelper.dart';
import 'package:garmian_house_of_charity/Views/gavenviews.dart';
import 'package:garmian_house_of_charity/mydrawer.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  HomePage createState() => HomePage();
}

// List<Map<String, dynamic>> jsonData = [];
List<HomeModel> data = [];

class HomePage extends State<MainPage> {
  dynamic famcount = "0",
      gavenrowcount = "0",
      gavenmoneycuont = "0",
      surgeryCount = "0",
      billedCount = "0",
      disabledCount = "0",
      longSickCount = "0",
      poorsCount = "0",
      aloneCount = "0",
      devorcedCount = "0",
      orphansCount = "0",
      notesCount = "0",
      writtenCount = "0",
      monthlyPaidCount = "0";
  int wholeDbCount = 0;

  Future<void> fetchData() async {
    jsonData.clear();

    try {
      final apiHelper = HomeHelper();
      data = await apiHelper.fetchData();
      for (var userData in data) {
        Map<String, dynamic> userMap = {
          'famCount': userData.Families,
          'gavenCount': userData.GavenRows,
          'gavenMoney': userData.GavenMoney,
          'alone': userData.Alone,
          'divorced': userData.Divorced,
          'disabled': userData.Disabled,
          'billed': userData.Billed,
          'longSick': userData.LongSick,
          'monthlyPaid': userData.MonthlyPaid,
          'noteCount': userData.Notes,
          'orphans': userData.Orphans,
          'poors': userData.poors,
          'surgeryCount': userData.surgery,
          'writtenCount': userData.written,
          'wholeDb': userData.wholedb,
        };
        jsonData.add(userMap);
        setState(() {
          famcount = userData.Families;
          gavenmoneycuont = userData.GavenMoney;
          aloneCount = userData.Alone;
          surgeryCount = userData.surgery;
          writtenCount = userData.written;
          notesCount = userData.Notes;
          disabledCount = userData.Disabled;
          devorcedCount = userData.Divorced;
          gavenrowcount = userData.GavenRows;
          poorsCount = userData.poors;
          orphansCount = userData.Orphans;
          monthlyPaidCount = userData.MonthlyPaid;
          longSickCount = userData.LongSick;
          billedCount = userData.Billed;
          wholeDbCount = userData.wholedb;
        });
      }

      print('Apollo Home Statics Has been Retreived Successfuly');
    } catch (e) {
      print('Apollo Error fetching datas of Home Statics: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(
          selectedIndex: 1,
        ),
        appBar: AppBar(
          leading: Builder(
              builder: (context) => Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'ماڵی خێرخوازان و هەژارانی گەرمیان',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              margin: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(3)),
              child: IntrinsicHeight(
                child: Column(children: [
                  const Text(
                    'ماڵی خێرخوازان و هەژارانی گەرمیان',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    '$wholeDbCount هێلی دیاری کراو لە سیستەمەکەدا نووسراوە',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ]),
              )),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          famcount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خشتەی خێزان',
                        ),
                      ]))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          gavenrowcount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خشتەی بەخشراو',
                        ),
                      ]))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          gavenmoneycuont.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'بڕی پارەی بەخشراو',
                        ),
                      ]))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          surgeryCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خشتەی نەشتەرگەری',
                        ),
                      ]))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          billedCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خ.م. کەفالەتکراو',
                        ),
                      ]))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          disabledCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خ. پێداویستی تایبەت',
                        ),
                      ]))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          longSickCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'نە. درێژخایەنەکان',
                        ),
                      ]))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          poorsCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خشتەی هەژاران',
                        ),
                      ]))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          aloneCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خشتەی بێ کەس',
                        ),
                      ]))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          devorcedCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خشتەی جیابوونەوە',
                        ),
                      ]))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          orphansCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'خشتەی بێ نازان',
                        ),
                      ]))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          notesCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'ژ. تێبینیەکان',
                        ),
                      ]))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          writtenCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'ژمارەی نووسراوەکان',
                        ),
                      ]))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue.shade100)),
                      child: Column(children: [
                        Text(
                          monthlyPaidCount.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          'کەفالەتی مانگانە',
                        ),
                      ]))),
            ])
          ]),
        ])));
  }
}
