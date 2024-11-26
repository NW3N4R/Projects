import 'package:flutter/material.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/homemodel.dart';
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

String totalRow = '';

class HomePage extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _loadDataOnStart();
  }

  Iterable<HomeModel>? mainlist = [];
  Future<void> _loadDataOnStart() async {
    // Call the API using the `requestData` method
    List<HomeModel>? data = await ConfigureApi()
        .requestData<HomeModel>("home", (json) => HomeModel.fromJson(json));
    if (data != null) {
      setState(() {
        mainlist = data
            .where((x) => !x.title.contains('کۆی ناوە تۆمارکراوەکان'))
            .toList()
          ..sort((a, b) => b.number.compareTo(a.number));
        totalRow = data
            .firstWhere((x) => x.title.contains('کۆی ناوە تۆمارکراوەکان'))
            .no;
      });
    } else {}
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
            style: TextStyle(color: Colors.black, fontSize: 18),
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
                      fontWeight: FontWeight.w900,
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    '$totalRow هێلی دیاری کراو لە سیستەمەکەدا نووسراوە',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              )),
          DataTable(
            columns: [
              DataColumn(
                label: const Text(
                  'خشتە',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onSort: (columnIndex, ascending) {},
              ),
              const DataColumn(
                label: Text(
                  'ژمارە',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            rows: mainlist?.map((model) {
                  return DataRow(cells: [
                    DataCell(
                      Text(
                        model.title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        model.no,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]);
                }).toList() ??
                [],
          )
        ])));
  }
}
