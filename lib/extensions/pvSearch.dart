import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
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
    ConfigureApi.subProfilesList = ConfigureApi.mainProfilesList;
    var hisotries = ConfigureApi.mainHistories;
    String txtToSearch = searchtxt.text,
        year = yeartxt.text,
        month = monthtxt.text,
        day = daytxt.text;
    DateTime dt = DateTime.now();
    if (txtToSearch.isNotEmpty) {
      ConfigureApi.subProfilesList = ConfigureApi.subProfilesList!.where((x) =>
          x.Name.contains(txtToSearch) || x.Address.contains(txtToSearch));
    }
    if (year.isNotEmpty) {
      ConfigureApi.subProfilesList = ConfigureApi.subProfilesList!
          .where((x) => hisotries!.any((z) {
                List<String> date = z.History.fixedDate.toString().split('-');
                return x.id == z.History.pid &&
                    date[0] == year; // Add your specific condition here
              }))
          .toList();
    }
    if (month.isNotEmpty) {
      ConfigureApi.subProfilesList = ConfigureApi.subProfilesList!
          .where((x) => hisotries!.any((z) {
                List<String> date = z.History.fixedDate.toString().split('-');
                return x.id == z.History.pid &&
                    date[1] == month; // Add your specific condition here
              }))
          .toList();
    }
    if (day.isNotEmpty) {
      ConfigureApi.subProfilesList = ConfigureApi.subProfilesList!
          .where((x) => hisotries!.any((z) {
                List<String> date = z.History.fixedDate.toString().split('-');
                return x.id == z.History.pid &&
                    date[2] == day; // Add your specific condition here
              }))
          .toList();
    }
    Donatedprofilesview.current.initliazeDataSource();
    setState(() {
      rowCount = ConfigureApi.subProfilesList!.length.toString();
      sumMoney = ConfigureApi.mainHistories!.where((x)=> ConfigureApi.subProfilesList!.any((z)=>x.History.pid == z.id)).fold(0.0, (sum,x)=> sum! + x.History.amount).toString();
    });
  }

  @override
  void initState() {
    super.initState();
    // rowCount = ConfigureApi.subProfilesList!.length.toString();
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
