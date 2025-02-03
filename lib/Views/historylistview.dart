import 'package:flutter/material.dart';
import 'package:garmian_house_of_charity/configureapi.dart';
import 'package:garmian_house_of_charity/Models/combinehistory.dart';
import 'package:garmian_house_of_charity/Updateres/donationupdate.dart';
import 'package:garmian_house_of_charity/Uploaders/newdonation.dart';
import 'package:garmian_house_of_charity/main.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HistoryListView extends StatefulWidget {
  final int proid; // Declare the pid parameter
  final String name;
  const HistoryListView({super.key, required this.proid, required this.name});
  static _HistoryListViewState? _current;
  static _HistoryListViewState get current => _current!;
  @override
  _HistoryListViewState createState() => _HistoryListViewState();
}

late int? rowCount;
late double? amountSum;


class _HistoryListViewState extends State<HistoryListView> {
  HistoryDataSource _historyDataSource = HistoryDataSource([]);

  @override
  void initState() {
    super.initState();
    initliaze();
    HistoryListView._current = this;
  }

  void initliaze() {
    _historyDataSource = HistoryDataSource(
        ConfigureApi.subHistories?.where((x) => x.History.pid == widget.proid).toList() ?? []);
    rowCount = ConfigureApi.subHistories?.where((x) => x.History.pid == widget.proid).length;
    amountSum = ConfigureApi.subHistories
        ?.where((x) => x.History.pid == widget.proid) // Filter by `pid`
        .fold(0.0, (sum, x) => sum! + x.History.amount);
  }

  void uploadpopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
                backgroundColor: Colors.white,
                content: SizedBox(
                  height: 300,
                  child: Newdonation(pid: widget.proid),
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.085,
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                      onPressed: () => uploadpopup(context),
                      icon: Icon(Icons.add)),
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
                      icon: const Icon(Icons.arrow_forward)),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                      'بڕ $amountSum',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    'هێڵ $rowCount',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ],
          )),
      body: Container(
        color: Colors.white,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: SfDataGridTheme(
              data: const SfDataGridThemeData(headerColor: Colors.white),
              child: SfDataGrid(
                source: _historyDataSource,
                gridLinesVisibility: GridLinesVisibility.both,
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
                    columnName: 'amount',
                    label: Container(
                      alignment: Alignment.center,
                      child: const Text('بڕ'),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'note',
                    label: Container(
                      alignment: Alignment.center,
                      child: const Text('تێبینی'),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'date',
                    label: Container(
                      alignment: Alignment.center,
                      child: const Text('بەروار'),
                    ),
                  ),
                  GridColumn(
                    width: MediaQuery.of(context).size.width * 0.1,
                    columnName: 'editcell',
                    allowFiltering: false,
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

class HistoryDataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  HistoryDataSource(List<CombinedHistories> combined) {
    _dataGridRows = combined.map<DataGridRow>((combined) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: combined.History.id),
        DataGridCell<double>(
            columnName: 'amount', value: combined.History.amount),
        DataGridCell<String>(columnName: 'note', value: combined.History.note),
        DataGridCell<String>(
            columnName: 'date', value: combined.History.fixedDate),
        DataGridCell(columnName: 'editcell', value: combined)
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        return Builder(
          builder: (BuildContext context) {
            if (dataCell.columnName == 'editcell') {
              return IconButton(
                  onPressed: () {
                    int id = row.getCells()[0].value;
                    CombinedHistories? d =
                        ConfigureApi.subHistories?.firstWhere((x) => x.History.id == id);
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
                                  height: 350,
                                  child: Updatedonation(
                                    bindcontext: d!,
                                  )),
                            ));
                      },
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ));
            } else {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                child: Text(
                  dataCell.value.toString(),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        );
      }).toList(),
    );
  }
}
