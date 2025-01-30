import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Helpers/configureapi.dart';
import 'package:garmian_house_of_charity/Models/combinehistory.dart';
import 'package:garmian_house_of_charity/Models/donationhistorymodel.dart';
import 'package:garmian_house_of_charity/main.dart';

class Updatedonation extends StatefulWidget {
  final CombinedHistories bindcontext;
  const Updatedonation({super.key, required this.bindcontext});
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Updatedonation> {
  DateTime now = DateTime.now();

  String? errorText;
  Future<void> update(BuildContext context) async {
    setState(() {
      if (yeartxtcontroller.text != DateTime.now().year.toString() &&
          yeartxtcontroller.text != (DateTime.now().year - 1).toString()) {
        errorText = 'ساڵ هەڵەیە';
        return;
      } else {
        errorText = null;
      }
    });
    String formattedDay =
        daytxtcontroller.text.padLeft(2, '0'); // Add leading zero if needed
    String formattedMonth =
        monthtxtcontroller.text.padLeft(2, '0'); // Add leading zero if needed

    String formattedDate =
        '${yeartxtcontroller.text}-$formattedMonth-$formattedDay';

    DateTime givingDate = DateTime.parse(formattedDate);
    DonationHistoryModel model = new DonationHistoryModel(
        id: widget.bindcontext.History.id,
        amount:moneytxtcontroller.text.isEmpty? 0:  double.parse(moneytxtcontroller.text),
        note: notetxtcontroller.text,
        givingDate: givingDate,
        pid: widget.bindcontext.History.pid);
    bool isup = await ConfigureApi().put("SubDonations/put", model);
    if (isup) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('سەرکەوتوو بوو')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('کێشەیەک ڕوویدا دووبارە هەوڵبدەرەوە')),
      );
    }
  }

  Future<void> delete(BuildContext context) async {
    bool isdel = await ConfigureApi()
        .delete("SubDonations/delete", widget.bindcontext.History.id);
    if (isdel) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('سەرکەوتوو بوو')),
      );
        MaterialPageRoute(
          builder: (context) => TabbedApp(
            initialIndex: 1,
          ),
        );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('کێشەیەک ڕوویدا دووبارە هەوڵبدەرەوە')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    notetxtcontroller.text = widget.bindcontext.History.note;
    moneytxtcontroller.text = widget.bindcontext.History.amount.toString();
    String dateString = widget.bindcontext.History.fixedDate.toString();
    List<String> date = dateString.split('-');
    yeartxtcontroller.text = date[0];
    monthtxtcontroller.text = date[1];
    daytxtcontroller.text = date[2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.center,
            child: const Text(
              'بەخشینی نوێ',
              style: TextStyle(fontSize: 18, fontFamily: 'DroidArabic'),
              textAlign: TextAlign.center,
            ),
          )),
      body: Container(
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: moneytxtcontroller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 4, right: 4, top: 1, bottom: 1),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade300)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade200)),
                      labelText: 'بڕی پارە',
                      hintText: 'بڕی پارە'),
                ),
                TextField(
                  controller: notetxtcontroller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 4, right: 4, top: 1, bottom: 1),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade300)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade200)),
                      labelText: 'تێبینی',
                      hintText: 'تێبینی'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: daytxtcontroller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only numeric characters
                          CustomRangeFormatter(
                              min: 1,
                              max: 31), // Set minimum and maximum values
                        ],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 4, right: 4, top: 1, bottom: 1),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade300)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade200)),
                            labelText: 'ڕۆژ',
                            hintText: 'ڕۆژ'),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        controller: monthtxtcontroller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CustomRangeFormatter(min: 1, max: 12),
                        ],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 4, right: 4, top: 1, bottom: 1),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade300)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade200)),
                            labelText: 'مانگ',
                            hintText: 'مانگ'),
                      ),
                    )),
                    Expanded(
                        child: TextField(
                      controller: yeartxtcontroller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 4, right: 4, top: 1, bottom: 1),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade300)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade200)),
                          labelText: 'ساڵ',
                          hintText: 'ساڵ',
                          errorText: errorText),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () async => await update(context),
                            child: Text(
                              'نوێ کردنەوە',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
                                  fontFamily: 'DroidArabic'),
                            ))),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return Directionality(
                                textDirection: TextDirection.rtl,
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'دڵنیای لە سڕینەوە؟',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: SizedBox(
                                      child: TextButton(
                                          onPressed: () => delete(context),
                                          child: Text(
                                            'سڕینەوە',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'DroidArabic'),
                                          ))),
                                ));
                          },
                        );
                      },
                    )
                  ],
                )
              ])),
    );
  }
}

class CustomRangeFormatter extends TextInputFormatter {
  final int min;
  final int max;

  CustomRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }
    return newValue;
  }
}

var moneytxtcontroller = TextEditingController();
var notetxtcontroller = TextEditingController();
var monthtxtcontroller =
    TextEditingController(text: DateTime.now().month.toString());
var daytxtcontroller =
    TextEditingController(text: DateTime.now().day.toString());
var yeartxtcontroller =
    TextEditingController(text: DateTime.now().year.toString());
