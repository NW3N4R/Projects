import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Models/combinehistory.dart';
import 'package:garmian_house_of_charity/Models/donatedprofilesmodel.dart';
import 'package:garmian_house_of_charity/Updateres/profileupdater.dart';
import 'package:garmian_house_of_charity/Uploaders/profilecreation.dart';
import 'package:garmian_house_of_charity/Views/historylistview.dart';
import 'package:garmian_house_of_charity/extensions/pvSearch.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:garmian_house_of_charity/configureapi.dart';

class Donatedprofilesview extends StatefulWidget {
  const Donatedprofilesview({super.key});
  static _donationprofileview? _current;
  // ignore: library_private_types_in_public_api
  static _donationprofileview get current => _current!;
  @override
  // ignore: library_private_types_in_public_api
  _donationprofileview createState() => _donationprofileview();
}

// ignore: camel_case_types
class _donationprofileview extends State<Donatedprofilesview> {
  GavenDataSource _gavenDataSource = GavenDataSource([]);
  @override
  void initState() {
    super.initState();
    Donatedprofilesview._current = this;
    initliazeDataSource();
  }
  void loadData() async {
    loadprofiles(); 
    loadhistories(); 
    initliazeDataSource();
  }

Future<void> loadprofiles() async {
  List<Donatedprofilesmodel>? profiles = await ConfigureApi()
      .requestData<Donatedprofilesmodel>(
          "donation", (json) => Donatedprofilesmodel.fromJson(json));

  ConfigureApi.mainProfilesList = profiles!; // Update the ValueNotifier
}

Future<void> loadhistories() async {
  List<CombinedHistories>? histories = await ConfigureApi()
      .requestData<CombinedHistories>(
          "SubDonations", (json) => CombinedHistories.fromJson(json));

  ConfigureApi.mainHistories = histories!; // Correct way to update ValueNotifier
}
  void initliazeDataSource() {
    setState(() {
      _gavenDataSource =
          GavenDataSource(ConfigureApi.subProfilesList!.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'خشتەی بەخشراو',
              style: TextStyle(fontFamily: 'DroidArabic'),
              textAlign: TextAlign.start,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  onPressed: () =>loadData(),
                  icon: const Icon(Icons.refresh)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileCreationView(),
                      ),
                    ).then((value) {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/')); // Pop until root
                    });
                  },
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                                title: Text(
                                  'گەڕان لە پرۆفایلەکان',
                                  style: TextStyle(fontFamily: 'DroidArabic'),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.white,
                                content: SizedBox(
                                  height: 250,
                                  child: pvSearch(),
                                )));
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  )),
            ])
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white // No visible border
            ),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: SfDataGridTheme(
              data: const SfDataGridThemeData(headerColor: Colors.blue),
              child: SfDataGrid(
                allowPullToRefresh: false,
                allowSorting: false,
                allowSwiping: true,
                source: _gavenDataSource,
                gridLinesVisibility: GridLinesVisibility.none,
                columns: <GridColumn>[
                  GridColumn(
                    visible: false,
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'id',
                    label: Container(
                      alignment: Alignment.center,
                      child: const Text('id'),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'name',
                    label: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'ناو',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'DroidArabic',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.auto,
                    columnName: 'phone',
                    label: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'ژ.مۆبایل',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'DroidArabic',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'address',
                    label: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'ناونیشان',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'DroidArabic',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    width: MediaQuery.of(context).size.width * 0.1,
                    columnName: 'editBtn',
                    allowFiltering: false,
                    allowSorting: false,
                    label: Container(
                      alignment: Alignment.center,
                      child: const Text(''),
                    ),
                  ),
                ],
                selectionMode: SelectionMode.single,
                navigationMode: GridNavigationMode.row,
              ),
            )),
      ),
    );
  }
}

class GavenDataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  GavenDataSource(List<Donatedprofilesmodel> gavenModels) {
    _dataGridRows = gavenModels.map<DataGridRow>((gavenModel) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: gavenModel.id),
        DataGridCell<String>(columnName: 'name', value: gavenModel.Name),
        DataGridCell<String>(columnName: 'phone', value: gavenModel.Phone),
        DataGridCell<String>(columnName: 'address', value: gavenModel.Address),
        DataGridCell<Donatedprofilesmodel>(
            columnName: 'editBtn', value: gavenModel),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      int index = effectiveRows.indexOf(row);
      if (index % 2 == 1) {
        return Colors.blue[50]!;
      } else {
        return Colors.white;
      }
    }

    return DataGridRowAdapter(
      color: getBackgroundColor(),
      cells: row.getCells().map<Widget>((dataCell) {
        return Builder(
          builder: (BuildContext context) {
            if (dataCell.columnName == "editBtn") {
              return Container(
                width: 20,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    int id = row
                        .getCells()[0]
                        .value; // Get the ID from the first cell
                    Donatedprofilesmodel? d = ConfigureApi.mainProfilesList
                        ?.firstWhere((x) => x.id == id);
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(
                                'نوێ کردنەوەی ئەرشیف',
                                textAlign: TextAlign.center,
                              ),
                              content: SizedBox(
                                  height: 250, child: ProfileUpdateView(d!)),
                            ));
                      },
                    );
                  },
                ),
              );
            }
            return GestureDetector(
              onDoubleTap: () {
                int id = row.getCells()[0].value;
                Donatedprofilesmodel d = ConfigureApi.mainProfilesList
                    ?.firstWhere((x) => x.id == id) as Donatedprofilesmodel;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryListView(
                            proid: d.id,
                            name: d.Name,
                          )),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                child: Text(
                  dataCell.value.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
