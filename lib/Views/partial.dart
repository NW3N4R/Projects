import 'package:flutter/material.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/partialmodel.dart';
import 'package:garmian_house_of_charity/mydrawer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/services.dart';

class Partialview extends StatefulWidget {
  const Partialview({super.key});

  @override
  PartialState createState() => PartialState();
}

class PartialState extends State<Partialview> {
  late PartialDataSource _partialDataSource = PartialDataSource([]);

  @override
  void initState() {
    super.initState();
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _loadDataOnStart();
  }


Future<void> _loadDataOnStart() async {
  // Call the API using the `requestData` method
  List<Partialmodel>? data = await ConfigureApi().requestData<Partialmodel>("Partial", (json) => Partialmodel.fromJson(json));
  if (data != null) {
    setState(() {
      _partialDataSource = PartialDataSource(data); // Update the data source
    });
  } else {
  }
}


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set RTL globally
      child: Scaffold(
        appBar: AppBar(title: const Text('Partial View')),
        drawer: MyDrawer(selectedIndex: 3),
        body: SfDataGrid(
          source: _partialDataSource,
          columns: [
            GridColumn(
              visible: false,
              columnName: 'id',
              columnWidthMode: ColumnWidthMode.fill,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'ID',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'name',
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'ناو',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              visible: true,
              columnName: 'phone',
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'ژ.مۆبایل',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              visible: true,
              columnName: 'city',
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'شار',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              visible: true,
              columnName: 'alley',
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'گەڕەک',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              visible: true,
              columnName: 'house',
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'خانوو',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              visible: true,
              columnName: 'carer',
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'بژیوی',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              visible: true,
              columnName: 'famNo',
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'ژ.خ',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              visible: true,
              columnName: 'note',
              columnWidthMode: ColumnWidthMode.fill,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'تێبینی',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              visible: true,
              columnName: 'tag',
              columnWidthMode: ColumnWidthMode.auto,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'خشتە',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartialDataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  PartialDataSource(List<Partialmodel> dataList) {
    _dataGridRows = dataList
        .map<DataGridRow>((data) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: data.id),
              DataGridCell<String>(columnName: 'name', value: data.name),
              DataGridCell<String>(columnName: 'phone', value: data.phone),
              DataGridCell<String>(columnName: 'city', value: data.city),
              DataGridCell<String>(columnName: 'alley', value: data.alley),
              DataGridCell<String>(columnName: 'house', value: data.house),
              DataGridCell<String>(columnName: 'carer', value: data.carer),
              DataGridCell<String>(columnName: 'famNo', value: data.famNo),
              DataGridCell<String>(columnName: 'note', value: data.note),
              DataGridCell<String>(columnName: 'tag', value: data.tag),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(cell.value.toString()),
        );
      }).toList(),
    );
  }
}
