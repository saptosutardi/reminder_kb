import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_reminder_kb/container_next_visiting_header.dart';
import 'package:flutter_reminder_kb/container_today.dart';
import 'NotificationService.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const String header = "Pengingat";
const String header2 = "KB Suntik";
const String today = "Hari ini";
const String dateToday = "";
const String nextVisiting = "Kunjungan Berikutnya";
String choose =
    "Pilih salah satu di bawah ini untuk mengaktifkan alarm/pengingat: ";
bool visiblilty1 = true;
bool visiblilty3 = true;
const String month = "Bulan";
const String dateNext1 = "16 Okt 2022";
const String dateNext3 = "11 Des 2022";
const String dayAgain = "hari lagi";
const String mommy = "bunda...";
String notif_1 = "KB Suntik 1 bulan";
String notif_3 = "Anda memilih yang 3 bulan";
String notif_2_day_before =
    "Anda akan diingatkan mulai 2 hari sebelum suntik KB berikutnya.";
String str_2_day_to_injection = "2 Hari lagi Anda harus suntik KB";
String str_1_day_to_injection = "1 Hari lagi Anda harus suntik KB";
String str_today_to_injection = "Hari ini Anda harus suntik KB";
var username;

final prefs = SharedPreferences.getInstance();

var visible2month = true;
const int startReminder = 2;
const Color background = Color(0XFFF7F5FD); // Color(0XFFFAF9FE);
const Color textPurple = Color(0XFF3D3F71);
const Color textRed = Color(0XFFBD1B4C);
const Color orange = Color(0XFFFE7443);
const Color purple = Color(0XFF8676FD);

void main() {
// to ensure all the widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

// to initialize the notificationservice
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Pengingat KB',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(textTheme),
      ),
      // theme:
      home: const MyHomePage(title: 'KB Suntik'),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('id')],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int textHeader = 0;
  int textDescription = 0;
  int injectionSelected = 0;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final nextOneMonth = now.add(const Duration(days: 28));
    String formatedDateSimple =
        DateFormat('dd MMM yy', "id_ID").format(nextOneMonth);
    final nextThreeMonth = now.add(const Duration(days: 28 * 3));
    String formatedDateSimple3 =
        DateFormat('dd MMM yy', "id_ID").format(nextThreeMonth);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
              text: header,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textPurple,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "\n$header2",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: textPurple,
                    decorationThickness: 0.1,
                  ),
                ),
              ]),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.people,
              color: textPurple,
            ),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: "Pengingat KB Suntik",
                applicationVersion: "2.0",
                applicationLegalese: null,
                children: const [
                  Text("Created:"),
                  Text("Mahasiswa Alih Jenjang D-IV"),
                  Text("Kebidanan angkatan IV"),
                  Text("Tahun ajaran 2022/2023"),
                  Text("STIKES Mataram"),
                  Divider(
                    color: purple,
                  ),
                  Text("Programmer: dr. Sapto Sutardi")
                ],
              );
            },
          )
        ],
        backgroundColor: background,
      ),
      body: Container(
        color: background,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ContainerToday(),
            const NextVisitingHeader(),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  choose,
                  style: const TextStyle(color: textRed),
                )),
            Row(
              children: [
                if (visiblilty1)
                  Expanded(
                      child: TextButton(
                          // On Pressed firs date
                          onPressed: () {
                            notification(notif_1, notif_2_day_before, 28, 1);
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: orange,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("KB",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 12,
                                        child: Center(
                                          child: Text(
                                            "1",
                                            style: TextStyle(color: orange),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("Bulan",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formatedDateSimple,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: const Text(
                                      "28 HARI LAGI",
                                      style: TextStyle(
                                          fontSize: 15, color: orange),
                                    ),
                                  )
                                ],
                              )))),
                const SizedBox(
                    // width: 10,
                    ),

                // Injeksi 3 bulan
                if (visiblilty3)
                  Visibility(
                    visible: true,
                    child: Expanded(
                        child: TextButton(
                            // On Pressed firs date
                            onPressed: () {
                              notification(
                                notif_1,
                                notif_2_day_before,
                                28,
                                3,
                              );
                            },
                            child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: purple,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text("KB",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 12,
                                          child: Center(
                                            child: Text(
                                              "3",
                                              style: TextStyle(
                                                color: purple,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text("Bulan",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            formatedDateSimple3,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: const Text(
                                        "84 HARI LAGI",
                                        style: TextStyle(
                                            fontSize: 15, color: purple),
                                      ),
                                    )
                                  ],
                                )))),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void notification(
      String? text1, String text2, int day, int monthSelected) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: background,
          title: const Text('Salamat Bunda...'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Anda sudah suntik KB."),
                Text(
                    'Selanjutnya aplikasi akan mengingatkan Anda, mulai 2 hari sebelum Anda harus berKB selanjutnya'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Oke'),
              onPressed: () async {
                NotificationService().showNotification(
                    1, "Waktunya untuk suntik KB", notif_1, day);
                NotificationService().showNotification2(
                    1, "Waktunya untuk suntik KB", notif_1, day);
                NotificationService().showNotification3(
                    1, "Waktunya untuk suntik KB", notif_1, day);
                Navigator.of(context).pop();
                visible2month = false;
                if (monthSelected == 1) {
                  visiblilty1 = true;
                  visiblilty3 = false;
                  injectionSelected = 1;
                } else {
                  visiblilty1 = false;
                  visiblilty3 = true;
                  injectionSelected = 3;
                }
                setState(() {
                  choose = "Anda sudah memilih KB $injectionSelected bulan...";
                });
              },
            ),
          ],
        );
      },
    );
  }
}
