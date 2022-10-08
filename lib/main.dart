import 'package:flutter/material.dart';
import 'package:flutter_reminder_kb/about_us.dart';
import 'package:flutter_reminder_kb/container_next_visiting_header.dart';
import 'package:flutter_reminder_kb/container_today.dart';
import 'package:restart_app/restart_app.dart';
import 'NotificationService.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const String header = "Pengingat";
const String header2 = "KB Suntik";
const String today = "Hari ini";
const String dateToday = "";
String choose = "Pilih salah satu KB yang sudah diberikan ";
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
String notif_1_month =
    "Anda akan diingatkan mulai 1 bulan sebelum suntik KB berikutnya.";

// final prefs = SharedPreferences.getInstance();

var visible2month = true;
const int startReminder = 2;
const Color background = Color(0XFFF7F5FD); // Color(0XFFFAF9FE);
const Color textPurple = Color(0XFF3D3F71);
const Color textRed = Color(0XFFBD1B4C);
const Color orange = Color(0XFFFF3d00); // Color(0XFFFE7443); //ff3d00
const Color purple = Color(0XFF7c4dff);
const Color purple_2 = Color(0XFF8676FD);
const Color orange_2 = Color(0XFFFE7443);
const Color blue = Color(0XFF536dfe);

bool isVisible1month = true;
bool isVisible3months = true;
bool isVisible3years = true;
bool isVisible5years = true;
bool isVisible8years = true;
bool isVisibleChoose = true;
bool isVisibleHaveInjection = false;
bool isVisibleLastWarning = false;

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
      home: const MyHomePage(title: 'KB Suntik Pengingat'),
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
  String _prefMonthSelected2 = "";

  void loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefMonthSelected = (prefs.getInt('counter') ?? 0);
      _prefMonthSelected2 = (prefs.getString('counter2') ?? "");
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
    String formatedDateSimple1;
    String formatedDateSimple3;
    String formatedDateSimple3Years;
    String formatedDateSimple5Years;
    String formatedDateSimple8Years;
    // DateTime dateNextVisiting = DateTime.now();
    print("--> get date length = $_prefMonthSelected2");

    int days28 = 28;
    int days84 = 84;
    int years3 = 365 * 3;
    int years5 = 365 * 5;
    int years8 = 365 * 8;
    if (_prefMonthSelected2.isNotEmpty) {
      DateTime data = DateTime.parse(_prefMonthSelected2);
      formatedDateSimple1 = DateFormat('d MMM yy', "id_ID").format(data);
      formatedDateSimple3 = formatedDateSimple1;
      formatedDateSimple3Years = formatedDateSimple1;
      formatedDateSimple5Years = formatedDateSimple1;
      formatedDateSimple8Years = formatedDateSimple1;
      final currentDate = DateTime.now();

      days28 = (data.difference(currentDate).inDays) + 1;
      if (currentDate.year == data.year &&
          currentDate.month == data.month &&
          currentDate.day == data.day) {
        days28 = 0;
        print("--> tanggal sama = $data");
      }

      days84 = days28;
    } else {
      final nextOneMonth = now.add(Duration(days: days28));
      formatedDateSimple1 =
          DateFormat('d MMM yy', "id_ID").format(nextOneMonth);
      final nextThreeMonth = now.add(Duration(days: days84));
      formatedDateSimple3 =
          DateFormat('d MMM yy', "id_ID").format(nextThreeMonth);
      final nextThreeYears = now.add(Duration(days: years3));
      formatedDateSimple3Years =
          DateFormat('d MMM yy', "id_ID").format(nextThreeYears);
      final nextFiveYears = now.add(Duration(days: years5));
      formatedDateSimple5Years =
          DateFormat('d MMM yy', "id_ID").format(nextFiveYears);
      final nextEightYears = now.add(Duration(days: years8));
      formatedDateSimple8Years =
          DateFormat('d MMM yy', "id_ID").format(nextEightYears);
    }

    print("--> counter => $_prefMonthSelected");

    if (_prefMonthSelected == 1) {
      setHideAlmostAllKindContraception();
      isVisible1month = true;
    } else if (_prefMonthSelected == 2) {
      setHideAlmostAllKindContraception();
      isVisible3months = true;
    } else if (_prefMonthSelected == 3) {
      setHideAlmostAllKindContraception();
      isVisible3years = true;
    } else if (_prefMonthSelected == 4) {
      setHideAlmostAllKindContraception();
      isVisible5years = true;
    } else if (_prefMonthSelected == 5) {
      setHideAlmostAllKindContraception();
      isVisible8years = true;
    }

    if (days84 < 1 || days28 < 1) {
      isVisibleLastWarning = true;
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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

            // KB 1 bulan
            ChoosingInstruction(isVisibleChoose: isVisibleChoose),
            Row(
              children: [
                Visibility(
                  visible: isVisible1month,
                  child: Expanded(
                      child: TextButton(
                          // On Pressed firs date
                          onPressed: () {
                            if (!isVisibleHaveInjection) {
                              dialogCongratulation(
                                  notif_1, notif_2_day_before, 28, "1_month");
                              print("--> select 1 mo");
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: orange_2,
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
                                            style: TextStyle(color: orange_2),
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
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                  Visibility(
                                    //courgette
                                    visible: isVisibleHaveInjection,
                                    child: Text(
                                      "Bunda harus berKB \npaling telat tanggal:",
                                      style: GoogleFonts.merienda(
                                        color: Colors.white,
                                        fontSize: 14,
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
                                          formatedDateSimple1,
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
                                    child: Text(
                                      "$days28 HARI LAGI",
                                      style: const TextStyle(
                                          fontSize: 15, color: orange),
                                    ),
                                  ),
                                  Visibility(
                                      visible: isVisibleLastWarning,
                                      child: Text(" berKB hari ini",
                                          style: GoogleFonts.merienda(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ))),
                                ],
                              )))),
                ),
                const SizedBox(
                    // width: 10,
                    ),

                // Injeksi 3 bulan
                Visibility(
                  visible: isVisible3months,
                  child: Expanded(
                      child: TextButton(
                          onPressed: () {
                            if (!isVisibleHaveInjection) {
                              dialogCongratulation(
                                notif_1,
                                notif_2_day_before,
                                84,
                                "3_months",
                              );
                              print("--> select 3mo");
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.only(right: 10),
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
                                            "3",
                                            style: TextStyle(
                                              color: orange,
                                            ),
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
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                  Visibility(
                                    //courgette
                                    visible: isVisibleHaveInjection,
                                    child: Text(
                                      "Bunda harus berKB \npaling telat tanggal:",
                                      style: GoogleFonts.merienda(
                                        color: Colors.white,
                                        fontSize: 14,
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
                                      border:
                                          Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Text(
                                      "$days84 HARI LAGI",
                                      style: const TextStyle(
                                          fontSize: 15, color: orange),
                                    ),
                                  ),
                                  Visibility(
                                      visible: isVisibleLastWarning,
                                      child: const Text(
                                          "Bunda HARUS berKB hari ini",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Colors.white))),
                                ],
                              )))),
                ),
              ],
            ),

            Visibility(
              visible: isVisible3years,
              child: TextButton(
                  // On Pressed firs date
                  onPressed: () {
                    if (!isVisibleHaveInjection) {
                      dialogCongratulation(
                          notif_1, notif_1_month, 365 * 3, "3_years");
                      print("--> IUD");
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: blue,
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
                                        color: Colors.white, fontSize: 16)),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Implan",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12,
                                child: Center(
                                  child: Text(
                                    "3",
                                    style: TextStyle(color: blue),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Tahun",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              )
                            ],
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.white,
                          ),
                          Visibility(
                            //courgette
                            visible: isVisibleHaveInjection,
                            child: Text(
                              "Bunda harus berKB \npaling telat tanggal:",
                              style: GoogleFonts.merienda(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formatedDateSimple3Years,
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
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              "3 TAHUN LAGI",
                              style: const TextStyle(fontSize: 15, color: blue),
                            ),
                          ),
                          Visibility(
                              visible: isVisibleLastWarning,
                              child: Text(" berKB hari ini",
                                  style: GoogleFonts.merienda(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ))),
                        ],
                      ))),
            ),

            // UID dan implan
            Row(
              children: [
                Visibility(
                  visible: isVisible5years,
                  child: Expanded(
                      child: TextButton(
                          // On Pressed firs date
                          onPressed: () {
                            if (!isVisibleHaveInjection) {
                              dialogCongratulation(
                                  notif_1, notif_1_month, 365 * 5, "5_years");
                              print("--> IUD");
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: purple_2,
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
                                        child: Text("IUD",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      ),
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 12,
                                        child: Center(
                                          child: Text(
                                            "5",
                                            style: TextStyle(color: purple_2),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("Tahun",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                  Visibility(
                                    //courgette
                                    visible: isVisibleHaveInjection,
                                    child: Text(
                                      "Bunda harus berKB \npaling telat tanggal:",
                                      style: GoogleFonts.merienda(
                                        color: Colors.white,
                                        fontSize: 14,
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
                                          formatedDateSimple5Years,
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
                                    child: Text(
                                      "5 TAHUN LAGI",
                                      style: const TextStyle(
                                          fontSize: 15, color: purple_2),
                                    ),
                                  ),
                                  Visibility(
                                      visible: isVisibleLastWarning,
                                      child: Text(" berKB hari ini",
                                          style: GoogleFonts.merienda(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ))),
                                ],
                              )))),
                ),
                const SizedBox(
                    // width: 10,
                    ),

                // IUD 8 tahun

                Visibility(
                  visible: isVisible8years,
                  child: Expanded(
                      child: TextButton(
                          // On Pressed firs date
                          onPressed: () {
                            if (!isVisibleHaveInjection) {
                              dialogCongratulation(
                                  notif_1, notif_1_month, 365 * 8, "8_years");
                              print("--> IUD");
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: purple,
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
                                        child: Text("IUD",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      ),
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 12,
                                        child: Center(
                                          child: Text(
                                            "8",
                                            style: TextStyle(color: purple_2),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("Tahun",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                  Visibility(
                                    //courgette
                                    visible: isVisibleHaveInjection,
                                    child: Text(
                                      "Bunda harus berKB \npaling telat tanggal:",
                                      style: GoogleFonts.merienda(
                                        color: Colors.white,
                                        fontSize: 14,
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
                                          formatedDateSimple8Years,
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
                                    child: Text(
                                      "8 TAHUN LAGI",
                                      style: const TextStyle(
                                          fontSize: 15, color: purple_2),
                                    ),
                                  ),
                                  Visibility(
                                      visible: isVisibleLastWarning,
                                      child: Text(" berKB hari ini",
                                          style: GoogleFonts.merienda(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ))),
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
      String? text1, String text2, int day, String monthSelected) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: background,
          title: const Text('Selamat Bunda...'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text("Bunda sudah suntik KB."),
                Text(text2),
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
                for (int i = 0; i < 3; i++) {
                  NotificationService().showNotification(i + 1,
                      "Waktunya untuk suntik KB", notif_1, ((day - 2) + i));
                }
// xamirin porting realtime msg -->
                Navigator.of(context).pop();
                visible2month = false;
                DateTime now = DateTime.now();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (monthSelected == "1_month") {
                  injectionSelected = 1;
                  prefs.setInt('counter', 1);
                  print("--> save pref = $monthSelected");
                  now = DateTime.now().add(const Duration(days: 28));
                } else if (monthSelected == "3_months") {
                  injectionSelected = 2;
                  prefs.setInt('counter', 2);
                  print("--> save pref = $monthSelected");
                  now = DateTime.now().add(const Duration(days: 84));
                } else if (monthSelected == "3_years") {
                  injectionSelected = 3;
                  prefs.setInt('counter', 3);
                  print("--> save pref = $monthSelected");
                  now = DateTime.now().add(const Duration(days: 365 * 3));
                } else if (monthSelected == "5_years") {
                  injectionSelected = 4;
                  prefs.setInt('counter', 4);
                  print("--> save pref = $monthSelected");
                  now = DateTime.now().add(const Duration(days: 365 * 5));
                } else {
                  injectionSelected = 5;
                  prefs.setInt('counter', 5);
                  print("--> save pref = $monthSelected");
                  now = DateTime.now().add(const Duration(days: 365 * 8));
                }
                print("--> save date = $now");

                prefs.setString('counter2', now.toString());

                Restart.restartApp();
              },
            ),
          ],
        );
      },
    );
  }

  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
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

  void setVisibilityAfterSelectContraseption(
      int i,
      List<bool> listContainerVisiblily,
      bool isVisibleChoose,
      bool isVisibleHaveInjection) {
    listContainerVisiblily.fillRange(0, listContainerVisiblily.length, false);
    listContainerVisiblily[i] = true;
    isVisibleChoose = false;
    isVisibleHaveInjection = true;
  }
}

void setHideAlmostAllKindContraception() {
  isVisible1month = false;
  isVisible3months = false;
  isVisible3years = false;
  isVisible5years = false;
  isVisible8years = false;
  isVisibleChoose = false;
  isVisibleHaveInjection = true;
}

class ChoosingInstruction extends StatelessWidget {
  const ChoosingInstruction({
    Key? key,
    required this.isVisibleChoose,
  }) : super(key: key);

  final bool isVisibleChoose;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisibleChoose,
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              choose,
              style: const TextStyle(color: textRed),
            )));
  }
}
