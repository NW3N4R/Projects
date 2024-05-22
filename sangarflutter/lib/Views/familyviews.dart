import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sangarflutter/Helpers/familiesHelper.dart';
import 'package:sangarflutter/Updateres/gavenupdater.dart';
import 'package:sangarflutter/Uploaders/gavenUplaoder.dart';
import 'package:sangarflutter/mydrawer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const familyviews());
}

// ignore: camel_case_types
class familyviews extends StatelessWidget {
  const familyviews({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خشتەی خێزان',
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
  FamilyHome createState() => FamilyHome();
}

bool isSearchByDate = false;
bool openSideCounter = false;
final searchfieldcontroller = TextEditingController();

List<Map<String, dynamic>> jsonData = [];
List<FamilyModel> data = [];

class FamilyHome extends State<MainPage> {
  Future<void> fetchData() async {
    jsonData.clear();
    final apiHelper = FamilyHelper();
    data = await apiHelper.fetchData();
    for (var userData in data) {
      Map<String, dynamic> userMap = {
        'id': userData.id,
        'name': userData.name,
        'phone': userData.phone,
        'city': userData.city,
        'apartment': userData.apartment,
        'house': userData.house,
        'life': userData.life,
        'famNo': userData.famNo,
        'note': userData.note,
      };
      jsonData.add(userMap);
    }
    setState(() {
      
    });
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
              DataGridCell<dynamic>(columnName: 'phone', value: item['phone']),
              DataGridCell<dynamic>(columnName: 'city', value: item['city']),
              DataGridCell<dynamic>(
                  columnName: 'apart', value: item['apartment']),
              DataGridCell<dynamic>(columnName: 'house', value: item['house']),
              DataGridCell<dynamic>(columnName: 'life', value: item['life']),
              DataGridCell<dynamic>(columnName: 'famno', value: item['famNo']),
              DataGridCell<dynamic>(columnName: 'note', value: item['note']),
            ]))
        .toList();
    final DataGridSource dataSource = _MyDataSource(dataGridRows, context);

    return Scaffold(
      drawer: MyDrawer(
        selectedIndex: 2,
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
                  fetchData();
                  setState(() {
                    
                  });
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
                      jsonData.clear();
                      for(var rows in data){
                        if(rows.name.contains(namesearchstr)){
                            Map<String, dynamic> userMap = {
                                    'id': rows.id,
                                    'name': rows.name,
                                    'phone': rows.phone,
                                    'city': rows.city,
                                    'apartment': rows.apartment,
                                    'house': rows.house,
                                    'life': rows.life,
                                    'famNo': rows.famNo,
                                    'note': rows.note,
                                  };
                        jsonData.add(userMap);

                        }
                      }
                      setState(() {
                        
                      });
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
                columnName: 'phone',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      'ژمارە مۆبایل',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'city',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'شار',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'apart',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'گەڕەک',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'house',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'خانوو',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'life',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'بژێوی',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'famno',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'ژ.خ',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'note',
                columnWidthMode: ColumnWidthMode.fill,
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'ت.ب',
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
              String id, name, note, money, date, address, phoneNo;

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
                            fieldstrday: strday,
                            fieldstrmonth: strmonth,
                            fieldstryear: stryear,
                          )));
            },
          ),
        );
      }).toList(),
    );
  }
}
