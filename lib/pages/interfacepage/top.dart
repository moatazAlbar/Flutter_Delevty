import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class toptext extends StatefulWidget {
  const toptext();

  @override
  _toptextState createState() => _toptextState();
}

class _toptextState extends State<toptext> {
  final textstyle =TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all( 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "اوقات الدوام لدينا من الساعة 8:00 ص الى 9:00 م",
            style: textstyle,

          ),
        ],
      ),
    );
  }
}
