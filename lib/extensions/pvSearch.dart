import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/configureapi.dart';
import 'package:garmian_house_of_charity/Views/donatedprofilesview.dart';

// ignore: camel_case_types
class pvSearch extends StatefulWidget {
  const pvSearch({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _pvsearch createState() => _pvsearch();
}

final searchtxt = TextEditingController();
final yeartxt = TextEditingController();
final monthtxt = TextEditingController();
final daytxt = TextEditingController();
String rowCount = "0", sumMoney = "0";

// ignore: camel_case_types
class _pvsearch extends State<pvSearch> {
  void search() {
    // Initialize with the original lists (no need to re-assign if they are already the same)
    ConfigureApi.subProfilesList = ConfigureApi
        .mainProfilesList; // Create a copy to avoid modifying the original list
    ConfigureApi.subHistories = ConfigureApi.mainHistories; // Create a copy

    setState(() {
      monthtxt.text =
          monthtxt.text.length == 1 ? '0${monthtxt.text}' : monthtxt.text;
      daytxt.text = daytxt.text.length == 1 ? '0${daytxt.text}' : daytxt.text;
    });

    String txtToSearch = searchtxt.text;
    String year = yeartxt.text;
    String month = monthtxt.text;
    String day = daytxt.text;

    // 1. Create a Map for fast History lookups:  This is the BIGGEST performance improvement.
    final historyMap = <int, List<String>>{}; // Map: pid -> [year, month, day]
    for (final history in ConfigureApi.subHistories!) {
      final dateParts = history.History.fixedDate.toString().split('-');
      historyMap[history.History.pid] = dateParts;
    }

    ConfigureApi.subProfilesList =
        ConfigureApi.subProfilesList!.where((profile) {
      // 2. Text Search (Do this FIRST to reduce the list size)
      if (txtToSearch.isNotEmpty &&
          !profile.Name.contains(txtToSearch) &&
          !profile.Address.contains(txtToSearch)) {
        return false; // Filter out if text search doesn't match
      }

      // 3. Date Filtering using the Map (Much faster!)
      if (year.isNotEmpty || month.isNotEmpty || day.isNotEmpty) {
        final dateParts = historyMap[profile.id];
        if (dateParts == null) {
          return false; // Profile has no matching history
        }

        if (year.isNotEmpty && dateParts[0] != year) {
          return false;
        }
        if (month.isNotEmpty && dateParts[1] != month) {
          return false;
        }
        if (day.isNotEmpty && dateParts[2] != day) {
          return false;
        }
      }

      return true; // Keep the profile if all conditions pass
    }).toList();

    Donatedprofilesview.current.initliazeDataSource();
    setState(() {
      rowCount = ConfigureApi.subProfilesList!.length.toString();

      // 4. Calculate sumMoney efficiently (after filtering)
      sumMoney = ConfigureApi.subHistories!
          .where((x) =>
              ConfigureApi.subProfilesList!.any((z) => x.History.pid == z.id))
          .fold(0.0, (sum, x) => sum + x.History.amount)
          .toString();
    });
  }

  @override
  void initState() {
    super.initState();
    rowCount = ConfigureApi.subProfilesList!.length.toString();
    sumMoney = ConfigureApi.mainHistories!
        .where((x) =>
            ConfigureApi.subProfilesList!.any((z) => x.History.pid == z.id))
        .fold(0.0, (sum, x) => sum + x.History.amount)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: searchtxt,
                //this feature will be enabled next year after more grouping
                // onChanged: (text) {
                //   setState(() {
                //     search();
                //   });
                // },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 4, right: 4, top: 1, bottom: 1),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade100)),
                  hintText: 'گەڕان بە پێی ناو و ناونیشان',
                ),
                style: const TextStyle(
                  fontFamily: 'DroidArabic',
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: yeartxt,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade100)),
                        hintText: 'ساڵ',
                      ),
                      style: const TextStyle(
                        fontFamily: 'DroidArabic',
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: monthtxt,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade100)),
                        hintText: 'مانگ',
                      ),
                      style: const TextStyle(
                        fontFamily: 'DroidArabic',
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: daytxt,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade300)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade100)),
                        hintText: 'ڕۆژ',
                      ),
                      style: const TextStyle(
                        fontFamily: 'DroidArabic',
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity, // Ensure the container takes 100% width
                alignment: Alignment.center, // Aligns the content to the right
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'کۆی ناوەکان \n$rowCount',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'DroidArabic',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'بڕی بەخشراو \n$sumMoney',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'DroidArabic',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  search();
                },
                child: const Text(
                  'وەرگرتن',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'DroidArabic',
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }
}
