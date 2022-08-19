import 'package:flutter/material.dart';
import 'package:pelindo_travel/screen/ringkasan_pemesanan/component/line_dot.dart';

class KotaAsalTujuanWidget extends StatelessWidget {
  final kotaAsal;
  final kotaTujuan;
  const KotaAsalTujuanWidget({
     Key key,
     this.kotaAsal,
     this.kotaTujuan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$kotaAsal',
          style: TextStyle(
            color: Color(0xff59597C),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'Arial',
          ),
        ),
        SizedBox(width: 8),
        LineDotWidget(),
        SizedBox(width: 8),
        Text(
          '$kotaTujuan',
          style: TextStyle(
            color: Color(0xff59597C),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'Arial',
          ),
        ),
      ],
    );
  }
}
