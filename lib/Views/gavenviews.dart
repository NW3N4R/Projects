import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/gavenmodel.dart';
import 'package:garmian_house_of_charity/Updateres/gavenupdater.dart';
import 'package:garmian_house_of_charity/Uploaders/gavenUplaoder.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class GavenView extends StatefulWidget {
  const GavenView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GavenHome createState() => _GavenHome();
}

bool isSearchByDate = false;
bool openSideCounter = false;
final searchtxt = TextEditingController();
final yeartxt = TextEditingController();
final monthtxt = TextEditingController();
final daytxt = TextEditingController();

// ignore: prefer_typing_uninitialized_variables
String r = "0", money = "0";
Iterable<Gavenmodel>? _list = [];

class _GavenHome extends State<GavenView> {
  GavenDataSource _gavenDataSource = GavenDataSource([]);

  @override
  void initState() {
    super.initState();
    _loadDataOnStart();
  }

  Future<void> _loadDataOnStart() async {
    _list = await ConfigureApi().requestData<Gavenmodel>(
        "GavenMoney", (json) => Gavenmodel.fromJson(json));
    if (mounted) {
      setState(() {
        // super.dispose();
        _gavenDataSource = GavenDataSource(_list?.toList() ?? []);
      });
    }
  }

  void search() {
    Iterable<Gavenmodel>? filter = _list;
    if (filter != null) {
      if (searchtxt.text.isNotEmpty) {
        filter = filter.where((x) =>
            x.name.contains(searchtxt.text) ||
            x.note.contains(searchtxt.text) ||
            x.address.contains(searchtxt.text));
      }

      // Check if year text is filled and matches the expected length (4 digits)
      if (yeartxt.text.length == 4) {
        filter = filter.where((x) => x.date.contains(yeartxt.text));
      }

      // Check if month text is filled
      if (monthtxt.text.isNotEmpty) {
        filter = filter.where((x) {
          // Extract the month from x.date
          final parts = x.date.split('-'); // Splits the string by '-'
          final month = parts[1]; // Gets the second part (month)

          return month.contains(monthtxt.text);
        }).toList();
      }

      // Check if day text is filled
      if (daytxt.text.isNotEmpty) {
        filter = filter.where((x) {
          // Extract the part after the last '-'
          final lastPart =
              x.date.split('-').last; // Gets the part after the last '-'

          // Compare with the input text
          return lastPart.contains(daytxt.text);
        }).toList();
      }
    }

    // After applying all the filters, _filter will hold the filtered data
    setState(() {
      _gavenDataSource = GavenDataSource(filter?.toList() ?? []);
      if (filter != null) {
        r = filter.length.toString();
        double m = filter.fold(0.0, (previousValue, x) {
          // Attempt to convert the 'money' string to a double
          double? moneyValue = double.tryParse(x.money);
          // If the conversion is successful, add it to the sum, otherwise add 0
          return previousValue + (moneyValue ?? 0.0);
        });
        money = m.toString();
      }
    });
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  const Text(
                    'گەڕان',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'DroidArabic',
                    ),
                  ),
                  TextField(
                    controller: searchtxt,
                    onChanged: (text) {
                      setState(() {
                        search();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'گەڕان بە پێی ناو و تێبینی و ناونیشان',
                    ),
                    style: const TextStyle(fontFamily: 'DroidArabic'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: yeartxt,
                          onChanged: (text) {
                            setState(() {
                              search();
                            });
                          },
                          decoration: const InputDecoration(hintText: 'ساڵ'),
                          style: const TextStyle(fontFamily: 'DroidArabic'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: monthtxt,
                          onChanged: (text) {
                            setState(() {
                              search();
                            });
                          },
                          decoration: const InputDecoration(hintText: 'مانگ'),
                          style: const TextStyle(fontFamily: 'DroidArabic'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: daytxt,
                          onChanged: (text) {
                            setState(() {
                              search();
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'ڕۆژ'),
                          style: const TextStyle(fontFamily: 'DroidArabic'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double
                        .infinity, // Ensure the container takes 100% width
                    alignment: Alignment
                        .centerRight, // Aligns the content to the right
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'کۆی ناوەکان $r',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'DroidArabic',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'بڕی بەخشراو $money',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'DroidArabic',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'وەرگرتن',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'DroidArabic',
                              color: Colors.black),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          // Clear logic here, if needed
                          searchtxt.clear();
                          yeartxt.clear();
                          monthtxt.clear();
                          daytxt.clear();
                          setState(() {
                            r = '2'; // Reset the value of r
                            money = '0'; // Reset the value of money
                            _gavenDataSource =
                                GavenDataSource(_list?.toList() ?? []);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'خشتەی بەخشراو',
                style: TextStyle(fontFamily: 'DroidArabic',fontSize: 14),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GavenUploaderView(),
                        ),
                      ).then((value) {
                        Navigator.popUntil(context,
                            ModalRoute.withName('/')); // Pop until root
                      });
                    },
                    icon: const Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _showPopup(context);
                      });
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _gavenDataSource =
                            GavenDataSource(_list?.toList() ?? []);
                      });
                    },
                    icon: const Icon(Icons.clear)),
              ])
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: SfDataGridTheme(
                data: const SfDataGridThemeData(headerColor: Colors.white),
                child: SfDataGrid(
                  allowPullToRefresh: true,
                  allowSorting: true,
                  allowSwiping: true,
                  source: _gavenDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                      visible: false,
                      columnName: 'id',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text('ID'),
                      ),
                    ),
                    GridColumn(
                      columnWidthMode: ColumnWidthMode.fill,
                      columnName: 'nameAndNote',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text('ناو\nتێبینی'),
                      ),
                    ),
                    GridColumn(
                      columnWidthMode: ColumnWidthMode.fitByCellValue,
                      columnName: 'moneyAndPhone',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text('بڕی پارە\nژ.مۆبایل'),
                      ),
                    ),
                    GridColumn(
                      columnWidthMode: ColumnWidthMode.fitByCellValue,
                      columnName: 'AddressAndDate',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text('بەروار\nناونیشان'),
                      ),
                    ),
                  ],
                  selectionMode: SelectionMode.single,
                  navigationMode: GridNavigationMode.row,
                ),
              )),
        ));
  }
}

class GavenDataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  GavenDataSource(List<Gavenmodel> gavenModels) {
    _dataGridRows = gavenModels.map<DataGridRow>((gavenModel) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: gavenModel.id),
        DataGridCell<String>(
            columnName: 'nameAndNote',
            value: '${gavenModel.name}\n${gavenModel.note}'),
        DataGridCell<String>(
            columnName: 'moneyAndPhone',
            value: '${gavenModel.money}\n${gavenModel.phone}'),
        DataGridCell<String>(
            columnName: 'AddressAndDate',
            value: '${gavenModel.address}\n${gavenModel.date}'),
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
            return GestureDetector(
              onTap: () {
                int id = row.getCells()[0].value;
                var d = _list?.firstWhere((x) => x.id == id);

                Clipboard.setData(ClipboardData(text: d.toString())).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('کۆپی کرا')),
                  );
                });
              },
              onDoubleTap: () {
                int id = row.getCells()[0].value;
                Gavenmodel d =
                    _list?.firstWhere((x) => x.id == id) as Gavenmodel;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GavenUpdateView(d)),
                );
              },
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerRight,
                child: Text(
                  dataCell.value.toString(),
                  textAlign: TextAlign.start,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
