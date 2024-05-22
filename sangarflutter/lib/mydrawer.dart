import 'package:flutter/material.dart';
import 'package:sangarflutter/Views/familyviews.dart';
import 'package:sangarflutter/Views/gavenviews.dart';
import 'package:sangarflutter/main.dart';
// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  int selectedIndex;

  // ignore: use_super_parameters
  MyDrawer({key, required this.selectedIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
            child: ListView(children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/mylogo.jpg',
                        width: 90,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('ماڵی خێرخوازان و هەژارانی گەرمیان')),
                    const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('ماڵێک بۆ ناساندنی هەژاران بە خێرخوازان')),
                    const Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: selectedIndex == 1
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'سەرەتا',
                      style: TextStyle(
                        color: selectedIndex == 1
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MainApp()));
                    },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 2
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.family_restroom,
                      color: selectedIndex == 2
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خشتەی خێزان',
                      style: TextStyle(
                        color: selectedIndex == 2
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const familyviews()));
                    },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 3
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.attach_money_sharp,
                      color: selectedIndex == 3
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خشتەی بەخشراو',
                      style: TextStyle(
                        color: selectedIndex == 3
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const gavenViews()));
                    },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 4
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.medical_information,
                      color: selectedIndex == 4
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خشتەی نەشتەر گەری',
                      style: TextStyle(
                        color: selectedIndex == 4
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const SurgeryViews()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 5
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.hail_rounded,
                      color: selectedIndex == 5
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خشتەی کەفالەت کراوان',
                      style: TextStyle(
                        color: selectedIndex == 5
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const BilledView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 6
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.wheelchair_pickup,
                      color: selectedIndex == 6
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خاوەن پێداویستی تایبەت',
                      style: TextStyle(
                        color: selectedIndex == 6
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const DisabledView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 7
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.sick,
                      color: selectedIndex == 7
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'نەخۆشیە درێژ خایەنەکان',
                      style: TextStyle(
                        color: selectedIndex == 7
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const LongSickView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 8
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.child_friendly,
                      color: selectedIndex == 8
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خشتەی منداڵانی بێ ناز',
                      style: TextStyle(
                        color: selectedIndex == 8
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const OrphansView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 9
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.heart_broken,
                      color: selectedIndex == 9
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خشتەی جیابوونەوە',
                      style: TextStyle(
                        color: selectedIndex == 9
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const DevorcedView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 10
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.food_bank,
                      color: selectedIndex == 10
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خشتەی هەژاران',
                      style: TextStyle(
                        color: selectedIndex == 10
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const PoorsView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 11
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.man,
                      color: selectedIndex == 11
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'خشتەی بێ کەسان',
                      style: TextStyle(
                        color: selectedIndex == 11
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const AloneView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 12
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.note_alt,
                      color: selectedIndex == 12
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'تێبینیەکان',
                      style: TextStyle(
                        color: selectedIndex == 12
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const NoteView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 13
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.book,
                      color: selectedIndex == 13
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'نووسراوی فەرمی',
                      style: TextStyle(
                        color: selectedIndex == 13
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const WrittenView()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 14
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.calendar_month,
                      color: selectedIndex == 14
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'مانگانەی کەفالەت کراوان',
                      style: TextStyle(
                        color: selectedIndex == 14
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const MonthlyPaidViews()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 15
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.photo,
                      color: selectedIndex == 15
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'گەلەری',
                      style: TextStyle(
                        color: selectedIndex == 15
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const GalleryViews()));
                    // },
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: selectedIndex == 16
                          ? Colors.blue.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: selectedIndex == 16
                          ? Colors.blue.shade300
                          : Colors.black,
                    ),
                    title: Text(
                      'ڕێکخستنەکان',
                      style: TextStyle(
                        color: selectedIndex == 16
                            ? Colors.blue.shade300
                            : Colors.black,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const SettingsView()));
                    // },
                  )),
            ])));
  }
}
