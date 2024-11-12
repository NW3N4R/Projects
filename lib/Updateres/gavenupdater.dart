import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garmian_house_of_charity/Views/gavenviews.dart';
import 'package:http/http.dart' as http;

late String strId,
    strName,
    strmoney,
    strnote,
    strday,
    strmonth,
    stryear,
    straddress,
    strphone,
    strADate = '00',
    strATime = '00',
    strADay = '00';

// ignore: must_be_immutable
class GavenUpdateView extends StatelessWidget {
  String fieldstrId,
      fieldstrName,
      fieldstrmoney,
      fieldstrnote,
      fieldstrday,
      fieldstrmonth,
      fieldstryear,
      fieldstraddress,
      fieldstrphoneNo;

  GavenUpdateView(
      {super.key,
      required this.fieldstrId,
      required this.fieldstrName,
      required this.fieldstrmoney,
      required this.fieldstrnote,
      required this.fieldstrday,
      required this.fieldstrmonth,
      required this.fieldstryear,
      required this.fieldstraddress,
      required this.fieldstrphoneNo});

  @override
  Widget build(BuildContext context) {
    strId = fieldstrId;
    strName = fieldstrName;
    strmoney = fieldstrmoney;
    strnote = fieldstrnote;
    strday = fieldstrday;
    strmonth = fieldstrmonth;
    stryear = fieldstryear;
    straddress = fieldstraddress;
    strphone = fieldstrphoneNo;
    return const MaterialApp(
      title: 'خشتەی بەخشراو >> نوێکردنەوە',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl, // Set the text direction to RTL
        child: MainGavenUpdater(),
      ),
    );
  }
}

class MainGavenUpdater extends StatefulWidget {
  const MainGavenUpdater({
    super.key,
  });
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MainGavenUpdater> {
  int delcount = 0;
  final nametxtcontroller = TextEditingController();
  final moneytxtcontroller = TextEditingController();
  final notetxtcontroller = TextEditingController();
  final daytxtcontroller = TextEditingController();
  final monthtxtcontroller = TextEditingController();
  final yeartxtcontroller = TextEditingController();
  final addresstxtcontroller = TextEditingController();
  final phonenotxtcontroller = TextEditingController();
  Future<void> updateVoid() async {
    strName = nametxtcontroller.text;
    strmoney = moneytxtcontroller.text;
    strnote = notetxtcontroller.text;
    strday = daytxtcontroller.text;
    strmonth = monthtxtcontroller.text;
    stryear = yeartxtcontroller.text;
    straddress = addresstxtcontroller.text;
    strphone = phonenotxtcontroller.text;

    final response = await http.post(
        Uri.parse(
            'http://p4165386.eero.online/api/gaven/updategaven/0/0/0/0/0/0/0/0/0/0/0/0'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': strId,
          'Name': nametxtcontroller.text,
          'Money': moneytxtcontroller.text,
          'Note': notetxtcontroller.text,
          'Year': yeartxtcontroller.text,
          'Month': monthtxtcontroller.text,
          'Day': daytxtcontroller.text,
          'PhoneNo': phonenotxtcontroller.text,
          'Address': addresstxtcontroller.text,
          'aday': '0',
          'adate': '0',
          'atime': '0'
        }));
    if (response.statusCode == 200) {
      print('Apollo the response code is OK');

    } else {
      print('Apollo the response code is ${response.statusCode}');

    }
  }

  Future<void> deleteVoid() async {
    delcount++;

    setState(() {});

    if (delcount == 3) {
      delcount = 0;

      final response = await http.get(
        Uri.parse('http://p4165386.eero.online/api/gaven/DeleteById/$strId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print('Apollo the response code is OK -- deleting');
      } else {
        print('Apollo the response code is ${response.statusCode} -- deleting');
        print('Apollo the id we sent was $strId -- deleting');

      }
    }
  }

  Future<void> fixDate() async {
    try {} catch (e) {
      // Fluttertoast.showToast(msg: "هەڵەیەک ڕوویدا");
    }
  }

  void LoadAutoDates(String id) async {
    //  await SqlConn.connect(
    //         ip: 'p4165386.eero.online',
    //         port: '1433',
    //         databaseName: 'Families',
    //         username: 'nwenar',
    //         password: 'KnnKnn123');

    //   var j = await SqlConn.readData(
    //       "select * from gavenMoney_Timeset where pid = '${strId}'");
    //   List<dynamic> data = jsonDecode(j);

    //   setState(() {
    //     for (var jData in data) {
    //       strADate = jData['Date'];
    //       strATime = jData['Time'];
    //       strADay = jData['Day'];
    //     }
    //   });
  }
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    nametxtcontroller.text = strName;
    moneytxtcontroller.text = strmoney;
    notetxtcontroller.text = strnote;
    daytxtcontroller.text = strday;
    monthtxtcontroller.text = strmonth;
    yeartxtcontroller.text = stryear;
    addresstxtcontroller.text = straddress;
    phonenotxtcontroller.text = strphone;
    LoadAutoDates(strId);
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
                'خشتەی بەخشراو >> نوێکردنەوە',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )),
        body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        'پێناس',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        strId.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        delcount.toString(),
                        style: const TextStyle(fontSize: 18),
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
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.all(4),
                        // width: MediaQuery.of(context).size.width / 2.2,
                        child: TextField(
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
                    ],
                  ),
                )),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          textDirection: TextDirection.ltr,
                          strATime,
                          style: const TextStyle(fontSize: 19),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          strADate,
                          style: const TextStyle(fontSize: 19),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          strADay,
                          style: const TextStyle(fontSize: 19),
                        ),
                      ),
                    ]),
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: [
                      Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                            onPressed: () => fixDate(),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 162, 0)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.merge,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  margin:
                                      const EdgeInsets.only(right: 15, left: 1),
                                  child: const Text(
                                    textAlign: TextAlign.center,
                                    'ڕێکخستنەوەی بەروار',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
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
                                      Icons.update,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      margin: const EdgeInsets.only(
                                          right: 15, left: 1),
                                      child: const Text(
                                        textAlign: TextAlign.center,
                                        'نوێکردنەوە',
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          ElevatedButton(
                            onPressed: () => deleteVoid(),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: Colors.red.shade500),
                            child: const Icon(
                              Icons.delete,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ]))
              ])),
        ));
  }
}
