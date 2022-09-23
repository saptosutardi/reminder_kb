import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';

const Color textPurple = Color(0XFF3D3F71);

const Color purple = Color(0XFF8676FD);

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: const Text(
        "Seting Ulang",
        style: TextStyle(color: textPurple),
      ),
      icon: const Icon(
        Icons.restore,
        color: textPurple,
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Seting Ulang'),
          content: const Text(
              'Bunda yakin untuk melakukan seting ulang alarm/pengingat?'),
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
              },

              // onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text(
                'Iya',
                style: TextStyle(color: textPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
