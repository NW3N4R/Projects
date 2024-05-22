import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sangarflutter/Views/gavenviews.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class GavenUploaderView extends StatelessWidget {
  const GavenUploaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'خشتەی بەخشراو >> نوێکردنەوە',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl, // Set the text direction to RTL
        child: MainGavenUploader(),
      ),
    );
  }
}

class MainGavenUploader extends StatefulWidget {
  const MainGavenUploader({
    super.key,
  });
  @override
  HomePage createState() => HomePage();
}
var nametxtcontroller = TextEditingController();
  var moneytxtcontroller = TextEditingController();
  var notetxtcontroller = TextEditingController();
  var daytxtcontroller = TextEditingController();
  var monthtxtcontroller = TextEditingController();
  var yeartxtcontroller = TextEditingController();
  var addresstxtcontroller = TextEditingController();
  var phonenotxtcontroller = TextEditingController();
class HomePage extends State<MainGavenUploader> {
  int delcount = 0;
  DateTime dt = DateTime.now();


  Future<void> updateVoid() async {
    
    String Aday = dt.weekday.toString();
    if (Aday == '1') {
      Aday = 'دوو شەممە';
    } else if (Aday == '2') {
      Aday = 'سێ شەممە';
    } else if (Aday == '3') {
      Aday = 'چوار شەممە';
    } else if (Aday == '4') {
      Aday = 'پێنج شەممە';
    } else if (Aday == '5') {
      Aday = 'هەیەنی';
    } else if (Aday == '6') {
      Aday = 'شەممە';
    } else if (Aday == '7') {
      Aday = ' شەممە';
    }

    final response = await http.post(
        Uri.parse(
            'http://p4165386.eero.online/api/gaven/postgaven/0/0/0/0/0/0/0/0/0/0/0'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Name': nametxtcontroller.text,
          'Money': moneytxtcontroller.text,
          'Note': notetxtcontroller.text,
          'Year': yeartxtcontroller.text,
          'Month': monthtxtcontroller.text,
          'Day': daytxtcontroller.text,
          'PhoneNo': phonenotxtcontroller.text,
          'Address': addresstxtcontroller.text,
          'aday': Aday,
          'adate': '${dt.year} / ${dt.month} / ${dt.day}',
          'atime': '${dt.hour} : ${dt.minute} : ${dt.minute}'
        }));
    if (response.statusCode == 200) {
      print('Apollo the response code is OK -- uploading');
      Fluttertoast.showToast(msg: 'تۆمارکردن سەرکەوتوو بوو');
    } else {
      print('Apollo the response code is ${response.statusCode} --uploading');
      // print('Apollo the param we sent was ${model.name} --uploading');
      Fluttertoast.showToast(msg: 'هەڵەیەک ڕوویدا');
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    yeartxtcontroller.text = DateTime.now().year.toString();
        monthtxtcontroller.text = DateTime.now().month.toString();

    daytxtcontroller.text = DateTime.now().day.toString();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const gavenViews()));
                },
                icon: const Icon(Icons.arrow_forward))
          ],
          title: Container(
            margin: const EdgeInsets.only(right: 1),
            alignment: Alignment.center,
            child: const Text(
              'خشتەی بەخشراو >> تۆمار کردن',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          )),
      body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
              child: Column(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      // width: MediaQuery.of(context).size.width / 2.2,
                      child: TextField(
                        textDirection: TextDirection.rtl,
                        controller: nametxtcontroller,
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
                            labelText: 'ناو',
                            hintText: 'ناو'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      // width: MediaQuery.of(context).size.width / 2.2,
                      child: TextField(
                        textDirection: TextDirection.rtl,
                        controller: moneytxtcontroller,
                        keyboardType: TextInputType.number,
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
                            labelText: 'بڕی پارە',
                            hintText: 'بڕی پارە'),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      // width: MediaQuery.of(context).size.width / 2.2,
                      child: TextField(
                        textDirection: TextDirection.rtl,
                        controller: notetxtcontroller,
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
                            labelText: 'تێبینی',
                            hintText: 'تێبینی'),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      // width: MediaQuery.of(context).size.width / 2.2,
                      child: TextField(
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
                        controller: addresstxtcontroller,
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
                            labelText: 'ناونیشان',
                            hintText: 'ناونیشان'),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      // width: MediaQuery.of(context).size.width / 2.2,
                      child: TextField(
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        controller: phonenotxtcontroller,
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
                            labelText: 'ژمارە تەلەفون',
                            hintText: 'ژمارە تەلەفون'),
                      ),
                    ),
                  ],
                ),
                IntrinsicWidth(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.all(4),
                        // width: MediaQuery.of(context).size.width / 2.2,
                        child: TextField(
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          controller: yeartxtcontroller,
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
                              hintText: 'ساڵ'),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.all(4),
                        // width: MediaQuery.of(context).size.width / 2.2,
                        child: TextField(
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          controller: monthtxtcontroller,
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
                          child: Container(
                        margin: const EdgeInsets.all(4),
                        // width: MediaQuery.of(context).size.width / 2.2,
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          controller: daytxtcontroller,
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
                      )),
                    ],
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 150,
                        child: ElevatedButton(
                          onPressed: () => updateVoid(),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: Colors.blue.shade500),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.upload,
                                size: 30,
                                color: Colors.white,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.8,
                                margin:
                                    const EdgeInsets.only(right: 15, left: 1),
                                child: const Text(
                                  textAlign: TextAlign.center,
                                  'تۆمار کردن',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                )
              ]))),
    );
  }
}
