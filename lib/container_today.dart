import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color textPurple = Color(0XFF3D3F71);

class ContainerToday extends StatelessWidget {
  const ContainerToday({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String formatedToday = DateFormat('dd MMM yyyy').format(now);
    String dateOfToday = formatedToday;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
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
                fontWeight: FontWeight.bold, color: textPurple, fontSize: 18),
          ),
          Text(
            dateOfToday,
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: textPurple, fontSize: 18),
          )
        ],
      ),
    );
  }
}
