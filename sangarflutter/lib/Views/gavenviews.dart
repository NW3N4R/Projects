import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sangarflutter/Helpers/gavenHelper.dart';
import 'package:sangarflutter/Updateres/gavenupdater.dart';
import 'package:sangarflutter/Uploaders/gavenUplaoder.dart';
import 'package:sangarflutter/mydrawer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const gavenViews());
}

// ignore: camel_case_types
class gavenViews extends StatelessWidget {
  const gavenViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خشتەی بەخشراو',
      home: Directionality(
        textDirection: TextDirection.rtl, // Set the text direction to RTL
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  GavenHome createState() => GavenHome();
}

bool isSearchByDate = false;
bool openSideCounter = false;
final searchfieldcontroller = TextEditingController();
final yearfieldcontroller = TextEditingController();
final dayfieldcontroller = TextEditingController();
final monthfieldcontroller = TextEditingController();

// ignore: prefer_typing_uninitialized_variables
var rowCounts, moneySum;
String r = "", m = "";
List<Map<String, dynamic>> jsonData = [];
List<UserData> data = [];

class GavenHome extends State<MainPage> {
  Future<void> fetchData() async {
    jsonData.clear();

    try {
      final apiHelper = GavenHelper();
      data = await apiHelper.fetchData();
      data.forEach((userData) {
        Map<String, dynamic> userMap = {
          'id': userData.id,
          'name': userData.name,
          'note': userData.note,
          'money': userData.money,
          'year': userData.year,
          'month': userData.month,
          'day': userData.day,
          'address': userData.address,
          'phoneNo': userData.phoneNo,
          'date': userData.date
        };
        jsonData.add(userMap);
      });
      setState(() {
        rowCounts = jsonData.length.toString();
        moneySum = 0;
        jsonData.forEach((element) {
          moneySum += double.parse(element['money']);
        });
      });

      print('Apollo Gaven Datas Has been Retreived Successfuly');
    } catch (e) {
      print('Apollo Error fetching datas of Gaven: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final List<DataGridRow> dataGridRows = jsonData
        .map((item) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: item['id']),
              DataGridCell<dynamic>(columnName: 'name', value: item['name']),
              DataGridCell<dynamic>(columnName: 'note', value: item['note']),
              DataGridCell<dynamic>(columnName: 'Money', value: item['money']),
              DataGridCell<dynamic>(columnName: 'date', value: item['date']),
              DataGridCell<dynamic>(
                  columnName: 'Address', value: item['address']),
              DataGridCell<dynamic>(
                  columnName: 'PhoneNo', value: item['phoneNo']),
            ]))
        .toList();
    final DataGridSource dataSource = _MyDataSource(dataGridRows, context);

    return Scaffold(
      bottomSheet: Container(
          // height: MediaQuery.of(context).size.height / 5,

          decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.all(10),
          child: IntrinsicWidth(
              child: IntrinsicHeight(
            child: Row(children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (openSideCounter == false) {
                        openSideCounter = true;
                      } else {
                        openSideCounter = false;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                  )),
              Visibility(
                  visible: openSideCounter,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'هێڵی دیاری کراو',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Text(
                                textAlign: TextAlign.left,
                                rowCounts.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'بڕی پارەی بەخشراو',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Text(
                                moneySum.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ))
                        ],
                      )
                    ],
                  ))
            ]),
          ))),
      drawer: MyDrawer(
        selectedIndex: 3,
      ),
      appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          elevation: 0,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainGavenUploader()));
                },
                icon: const Icon(
                  Icons.upload,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  searchfieldcontroller.text = "";
                  dayfieldcontroller.text = "1";
                  monthfieldcontroller.text = "";
                  yearfieldcontroller.text = "";
                  fetchData(); // Wait for fetchData() to complete

                  //  setState(() {});
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ],
          title: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (isSearchByDate == false) {
                          isSearchByDate = true;
                        } else {
                          isSearchByDate = false;
                        }
                      });
                    },
                    icon:
                        const Icon(Icons.calendar_month, color: Colors.white)),
                Visibility(
                    visible: isSearchByDate,
                    child: IntrinsicWidth(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        controller: dayfieldcontroller,
                        decoration: InputDecoration(
                            constraints: const BoxConstraints(
                                minWidth: 40, maxWidth: 50),
                            contentPadding: const EdgeInsets.all(4),
                            hintText: 'ڕۆژ',
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.blue.shade50)),
                            hintStyle: const TextStyle(color: Colors.black)),
                      ),
                    )),
                Visibility(
                    visible: isSearchByDate,
                    child: Container(
                        constraints:
                            const BoxConstraints(minWidth: 40, maxWidth: 50),
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: IntrinsicWidth(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            controller: monthfieldcontroller,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(4),
                                hintText: 'مانگ',
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blue.shade50)),
                                hintStyle:
                                    const TextStyle(color: Colors.black)),
                          ),
                        ))),
                Visibility(
                    visible: isSearchByDate,
                    child: IntrinsicWidth(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        controller: yearfieldcontroller,
                        decoration: InputDecoration(
                            constraints: const BoxConstraints(
                                minWidth: 40, maxWidth: 50),
                            contentPadding: const EdgeInsets.all(7),
                            hintText: 'ساڵ',
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.blue.shade50)),
                            hintStyle: const TextStyle(color: Colors.black)),
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width / 2.3,
                    constraints:
                        const BoxConstraints(minWidth: 200, maxWidth: 250),
                    child: IntrinsicWidth(
                        child: TextField(
                      maxLines: 1,
                      controller: searchfieldcontroller,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(4),
                          hintText: 'گەڕان',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue.shade50)),
                          hintStyle: const TextStyle(color: Colors.black)),
                    ))),
                IconButton(
                    onPressed: () {
                      String namesearchstr = searchfieldcontroller.text;
                      String daysearchstr = dayfieldcontroller.text;
                      String monthsearchstr = monthfieldcontroller.text;
                      String yearsearchstr = yearfieldcontroller.text;

                      // user searchs by date or name
                      if (isSearchByDate == true) {
                        //user searchs only by date
                        if (searchfieldcontroller.text == "") {
                          // if user searchs by day and other
                          if (dayfieldcontroller.text != "") {
                            setState(() {
                              jsonData.clear();

                              for (var userData in data) {
                                if (userData.day == daysearchstr &&
                                    userData.month == monthsearchstr &&
                                    userData.year == yearsearchstr) {
                                  Map<String, dynamic> userMap = {
                                    'id': userData.id,
                                    'name': userData.name,
                                    'note': userData.note,
                                    'money': userData.money,
                                    'year': userData.year,
                                    'month': userData.month,
                                    'day': userData.day,
                                    'address': userData.address,
                                    'phoneNo': userData.phoneNo,
                                    'date': userData.date
                                  };
                                  jsonData.add(userMap);
                                }
                              }

                              rowCounts = jsonData.length.toString();
                              moneySum = 0;
                              jsonData.forEach((element) {
                                moneySum += double.parse(element['money']);
                              });
                            });
                          }
                          //user wants only search by year
                          else if (dayfieldcontroller.text == "" &&
                              monthfieldcontroller.text == "") {
                            setState(() {
                              jsonData.clear();

                              for (var userData in data) {
                                if (userData.year == yearsearchstr) {
                                  Map<String, dynamic> userMap = {
                                    'id': userData.id,
                                    'name': userData.name,
                                    'note': userData.note,
                                    'money': userData.money,
                                    'year': userData.year,
                                    'month': userData.month,
                                    'day': userData.day,
                                    'address': userData.address,
                                    'phoneNo': userData.phoneNo,
                                    'date': userData.date
                                  };
                                  jsonData.add(userMap);
                                }
                              }

                              rowCounts = jsonData.length.toString();
                              moneySum = 0;
                              jsonData.forEach((element) {
                                moneySum += double.parse(element['money']);
                              });
                            });
                          }
                          //if user searchs only by month and year
                          else {
                            setState(() {
                              jsonData.clear();

                              for (var userData in data) {
                                if (userData.month == monthsearchstr &&
                                    userData.year == yearsearchstr) {
                                  Map<String, dynamic> userMap = {
                                    'id': userData.id,
                                    'name': userData.name,
                                    'note': userData.note,
                                    'money': userData.money,
                                    'year': userData.year,
                                    'month': userData.month,
                                    'day': userData.day,
                                    'address': userData.address,
                                    'phoneNo': userData.phoneNo,
                                    'date': userData.date
                                  };
                                  jsonData.add(userMap);
                                }
                              }

                              rowCounts = jsonData.length.toString();
                              moneySum = 0;
                              jsonData.forEach((element) {
                                moneySum += double.parse(element['money']);
                              });
                            });
                          }
                        }
                        //user searchs by name and date
                        else {
                          // if user searchs by day and other
                          if (dayfieldcontroller.text != "") {
                            setState(() {
                              jsonData.clear();

                              data.forEach((userData) {
                                if (userData.name.contains(namesearchstr) &&
                                    userData.day == daysearchstr &&
                                    userData.month == monthsearchstr &&
                                    userData.year == yearsearchstr) {
                                  Map<String, dynamic> userMap = {
                                    'id': userData.id,
                                    'name': userData.name,
                                    'note': userData.note,
                                    'money': userData.money,
                                    'year': userData.year,
                                    'month': userData.month,
                                    'day': userData.day,
                                    'address': userData.address,
                                    'phoneNo': userData.phoneNo,
                                    'date': userData.date
                                  };
                                  jsonData.add(userMap);
                                }
                              });

                              rowCounts = jsonData.length.toString();
                              moneySum = 0;
                              jsonData.forEach((element) {
                                moneySum += double.parse(element['money']);
                              });
                            });
                          }
                          //if user searchs only by month and year
                          else {
                            setState(() {
                              jsonData.clear();

                              data.forEach((userData) {
                                if (userData.name.contains(namesearchstr) &&
                                    userData.month == monthsearchstr &&
                                    userData.year == yearsearchstr) {
                                  Map<String, dynamic> userMap = {
                                    'id': userData.id,
                                    'name': userData.name,
                                    'note': userData.note,
                                    'money': userData.money,
                                    'year': userData.year,
                                    'month': userData.month,
                                    'day': userData.day,
                                    'address': userData.address,
                                    'phoneNo': userData.phoneNo,
                                    'date': userData.date
                                  };
                                  jsonData.add(userMap);
                                }
                              });

                              rowCounts = jsonData.length.toString();
                              moneySum = 0;
                              jsonData.forEach((element) {
                                moneySum += double.parse(element['money']);
                              });
                            });
                          }
                        }
                      }
                      //user searchs by name
                      else {
                        setState(() {
                          jsonData.clear();

                          data.forEach((userData) {
                            if (userData.name.contains(namesearchstr)) {
                              Map<String, dynamic> userMap = {
                                'id': userData.id,
                                'name': userData.name,
                                'note': userData.note,
                                'money': userData.money,
                                'year': userData.year,
                                'month': userData.month,
                                'day': userData.day,
                                'address': userData.address,
                                'phoneNo': userData.phoneNo,
                                'date': userData.date
                              };
                              jsonData.add(userMap);
                            }
                          });

                          rowCounts = jsonData.length.toString();
                          moneySum = 0;
                          jsonData.forEach((element) {
                            moneySum += double.parse(element['money']);
                          });
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
              ]))),
      body: SfDataGrid(
          selectionMode: SelectionMode.single,
          source: dataSource,
          
          gridLinesVisibility: GridLinesVisibility.both,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          columns: [
            GridColumn(
                visible: false,
                columnName: 'id',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'id',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'name',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'ناو',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'Note',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      'تێبینی',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'Money',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'بڕی پارە',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'date',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'بەروار',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'Address',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'ناونیشان',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'PhoneNo',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'ژمارە تەلەفون',
                      overflow: TextOverflow.ellipsis,
                    ))),
          ]),
    );
  }
}

late List<String> cellValues;

class _MyDataSource extends DataGridSource {
  _MyDataSource(this.source, this.context);
  final BuildContext context;
  final List<DataGridRow> source;

  @override
  List<DataGridRow> get rows => source;

  int currentCellIndex = 0; // Initialize with 0 to display the first cell

  late List<String> cellValues;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    cellValues = List.filled(row.getCells().length, '');

    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map<Widget>((entry) {
        final DataGridCell cell = entry.value;

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            child: Text(
              cell.value.toString(),
              textAlign: TextAlign.right,
            ),
            onTap: () async {
              // ignore: unused_local_variable
              String id,
                  name,
                  note,
                  money,
                  date,
                  address,
                  phoneNo;

              for (int i = 0; i < row.getCells().length; i++) {
                cellValues[i] = row.getCells()[i].value.toString();
              }

              id = cellValues[0].toString();
              name = cellValues[1].toString();
              note = cellValues[2].toString();
              money = cellValues[3].toString();
              date = cellValues[4];
              address = cellValues[5];
              phoneNo = cellValues[6];
              await Clipboard.setData(ClipboardData(
                  text:
                      'ناو: $name \nتێبینی: $note \nبڕی پارە : $money \nبەروار : $date \n ناونیشان: $address \n ژمارە تەلەفون: $phoneNo'));
            },
            onDoubleTap: () {
              for (int i = 0; i < row.getCells().length; i++) {
                cellValues[i] = row.getCells()[i].value.toString();
              }

              for (var userData in data) {
                if (userData.id.toString() == cellValues[0]) {

                strday = userData.day;
                  strmonth = userData.month;
                  stryear = userData.year;
                }
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GavenUpdateView(
                            fieldstrId: cellValues[0].toString(),
                            fieldstrName: cellValues[1],
                            fieldstrnote: cellValues[2],
                            fieldstrmoney: cellValues[3],
                            fieldstraddress: cellValues[5],
                            fieldstrphoneNo: cellValues[6],
                            fieldstrday:  strday,
                            fieldstrmonth:  strmonth,
                            fieldstryear: stryear,
                          )));
            },
          ),
        );
      }).toList(),
    );
  }
}
