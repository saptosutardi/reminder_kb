import 'package:flutter/material.dart';

const Color textPurple = Color(0XFF3D3F71);

const Color purple = Color(0XFF8676FD);

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: const Text(
        "Tentang Aplikasi",
        style: TextStyle(color: textPurple),
      ),
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
    );
  }
}
