import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

const Color textPurple = Color(0XFF3D3F71);

class NextVisitingHeader extends StatelessWidget {
  const NextVisitingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
