import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DateTabInActive extends StatelessWidget {
  final date;
  final day;
  const DateTabInActive({
    Key key,
     this.date,
    this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(right: getProportionateScreenWidth(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0.5,
            offset: Offset(0, 0.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              color: Color(0xff88879C),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
            ),
          ),
          SizedBox(height: 8),
          Text(
            day,
            style: TextStyle(
              color: Color(0xff88879C),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
            ),
          ),
        ],
      ),
    );
  }
}

class DateTabActive extends StatelessWidget {
  final date;
  final day;
  const DateTabActive({
    Key key,
     this.date,
     this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(right: getProportionateScreenWidth(16)),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0.5,
            offset: Offset(0, 0.5),
          ),
        ],
        gradient: RadialGradient(
          colors: [
            Color(0xff85D3FF),
            Color(0xff2596D7),
          ],
          center: Alignment.topRight,
          radius: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
            ),
          ),
          SizedBox(height: 8),
          Text(
            day,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
            ),
          ),
        ],
      ),
    );
  }
}