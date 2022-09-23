import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_reminder_kb/about_us.dart';
import 'package:flutter_reminder_kb/container_next_visiting_header.dart';
import 'package:flutter_reminder_kb/container_today.dart';
import 'package:flutter_reminder_kb/reset.dart';
import 'package:restart_app/restart_app.dart';
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
int distance1 = 0;
int distance3 = 0;
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

// final prefs = SharedPreferences.getInstance();

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
  int _prefMonthSelected = 0;

  void loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefMonthSelected = (prefs.getInt('counter') ?? 0);
    });
  }

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    loadCounter();
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

    print("--> counter => $_prefMonthSelected");
    bool isVisible1 = true;
    bool isVisible3 = true;
    bool isVisibleChoose = true;
    bool isVisibleHaveInjection = false;
    if (_prefMonthSelected == 1) {
      isVisible1 = true;
      isVisible3 = false;
      isVisibleChoose = false;
      isVisibleHaveInjection = true;
    } else if (_prefMonthSelected == 3) {
      isVisible1 = false;
      isVisible3 = true;
      isVisibleChoose = false;
      isVisibleHaveInjection = true;
    }

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
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: textPurple),
            itemBuilder: (context) => [
              const PopupMenuItem(child: AboutUs()),
              PopupMenuItem(
                child: TextButton.icon(
                  label: const Text(
                    "Hapus Pengingat",
                    style: TextStyle(color: textPurple),
                  ),
                  icon: const Icon(
                    Icons.restore,
                    color: textPurple,
                  ),
                  onPressed: () => dialogReset(),
                ),
              ),
            ],
          ),
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
            Visibility(
                visible: isVisibleChoose,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      choose,
                      style: const TextStyle(color: textRed),
                    ))),
            Row(
              children: [
                Visibility(
                  visible: isVisible1,
                  child: Expanded(
                      child: TextButton(
                          // On Pressed firs date
                          onPressed: () {
                            dialogCongratulation(
                                notif_1, notif_2_day_before, 28, 1);
                            print("--> select 1 mo");
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
                                    children: <Widget>[
                                      Visibility(
                                        visible: isVisibleHaveInjection,
                                        child: const Text("Bunda sudah suntik",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("KB",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      ),
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 12,
                                        child: Center(
                                          child: Text(
                                            "1",
                                            style: TextStyle(color: orange),
                                          ),
                                        ),
                                      ),
                                      const Padding(
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
                                  Visibility(
                                    //courgette
                                    visible: isVisibleHaveInjection,
                                    child: Text(
                                      "Bunda harus berKB sebelum tanggal:",
                                      style: GoogleFonts.merienda(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
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
                ),
                const SizedBox(
                    // width: 10,
                    ),

                // Injeksi 3 bulan
                if (isVisible3 == true)
                  Visibility(
                    visible: isVisible3,
                    child: Expanded(
                        child: TextButton(
                            onPressed: () {
                              dialogCongratulation(
                                notif_1,
                                notif_2_day_before,
                                28,
                                3,
                              );
                              print("--> select 3mo");
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

  void dialogCongratulation(
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
                Text("Buda sudah suntik KB."),
                Text(
                    'Selanjutnya aplikasi akan mengingatkan Bunda, mulai 2 hari sebelum Bunda harus berKB selanjutnya'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                'Cancel',
              ),
              child: const Text(
                'Tidak',
                style: TextStyle(color: textPurple),
              ),
            ),
            TextButton(
              child: const Text(
                'Oke',
                style: TextStyle(color: purple),
              ),
              onPressed: () async {
                NotificationService().showNotification(
                    1, "Waktunya untuk suntik KB", notif_1, day);
                Navigator.of(context).pop();
                visible2month = false;

                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (monthSelected == 1) {
                  injectionSelected = 1;
                  prefs.setInt('counter', monthSelected);
                  print("--> save pref = $monthSelected");
                } else {
                  injectionSelected = 3;
                  prefs.setInt('counter', monthSelected);
                  print("--> save pref = $monthSelected");
                }

                Restart.restartApp();
              },
            ),
          ],
        );
      },
    );
  }

  void dialogReset() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Hapus Pengingat'),
        content: const Text(
            'Pengingat akan diseting ulang. Memori alarm/pengingat akan dihapus. Bunda yakin untuk melakukan seting ulang alarm/pengingat?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(
              context,
              'Cancel',
            ),
            child: const Text(
              'Tidak',
              style: TextStyle(color: textPurple),
            ),
          ),
          TextButton(
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();

              Restart.restartApp();
              Navigator.pop(context, 'OK');
            },
            child: const Text(
              'Iya',
              style: TextStyle(color: textPurple),
            ),
          ),
        ],
      ),
    );
  }
}
