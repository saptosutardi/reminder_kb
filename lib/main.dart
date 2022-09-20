import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'NotificationService.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String header = "Pengingat";
const String header2 = "KB Suntik";
const String today = "Hari ini";
const String dateToday = "";
const String nextVisiting = "Kunjungan Berikutnya";
const String choose = "Pilih salah satu untuk pengingat";
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
    return MaterialApp(
      title: 'Pengingat KB',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
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

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String formatedToday = DateFormat('dd MMM yyyy').format(now);
    String dateOfToday = formatedToday;

    final nextOneMonth = now.add(const Duration(days: 28));
    String formatedOneMonth1 =
        DateFormat('dd MMM', "id_ID").format(nextOneMonth);
    String formatedOneMonth2 = DateFormat('yyyy').format(nextOneMonth);

    final nextThreeMonth = now.add(const Duration(days: 28 * 3));
    String formatedThreeMonth1 =
        DateFormat('dd MMM', "id_ID").format(nextThreeMonth);
    String formatedThreeMonth2 = DateFormat('yyyy').format(nextThreeMonth);

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
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: textPurple,
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                  const Text(
                    "Hari ini: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textPurple,
                        fontSize: 18),
                  ),
                  Text(
                    dateOfToday,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: textPurple,
                        fontSize: 18),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_right_outlined,
                      color: textPurple,
                      size: 32,
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Kunjungan Berikutnya: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textPurple,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Row(
                children: const <Widget>[
                  Flexible(
                    child: Text(
                      "Pilih salah satu di bawah ini untuk mengaktifkan alarm/pengingat: ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: textRed),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          notification(notif_1, notif_2_day_before);

                          final now = DateTime.now();
                          /* AndroidAlarmManager.oneShotAt(
                              now, 1, _oneShotAtTaskCallback); */
                          final int helloAlarmID = 0;
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
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 12,
                                      child: Center(
                                        child: Text(
                                          "1",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text("Bulan",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        formatedOneMonth1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      formatedOneMonth2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                          color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            )))),
                const SizedBox(
                    // width: 10,
                    ),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          notification(notif_1, notif_2_day_before);
                          /* AndroidAlarmManager.oneShotAt(
                            DateTime.now().add(const Duration(seconds: 1)),
                            123,
                            _oneShotAtTaskCallback(),
                            alarmClock: true,
                          ); */
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 12,
                                      child: Center(
                                        child: Text(
                                          "3",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text("Bulan",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        formatedThreeMonth1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      formatedThreeMonth2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                          color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            )))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void notification(String? text1, String text2) async {
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
              onPressed: () {
                NotificationService()
                    .showNotification(1, "Waktunya untuk suntik KB", notif_1);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /* String selected(int a) {
    String text;
    if (a == 1) {
      text = sele
    }
  } */
}
