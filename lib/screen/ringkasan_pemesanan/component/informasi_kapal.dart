import 'package:flutter/material.dart';
import 'package:pelindo_travel/screen/ringkasan_pemesanan/component/line_dot.dart';

import '../../../size_config.dart';

class InformasiKapalWidget extends StatelessWidget {
  final kotaAsal;
  final kotaTujuan;
  final waktu;
  final jenisKapal;
  final namaKapal;
  final keberangkatan;
  final lokasi;

  const InformasiKapalWidget({
     Key key,
     this.kotaAsal,
     this.kotaTujuan,
     this.waktu,
     this.jenisKapal,
     this.namaKapal,
     this.keberangkatan,
     this.lokasi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0.5,
            offset: Offset(0.5, 1.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    kotaAsal,
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
                    kotaTujuan,
                    style: TextStyle(
                      color: Color(0xff59597C),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: 4),
                      Text(
                        waktu,
                        style: TextStyle(
                          color: Color(0xff979797),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          VerticalSpacing(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Image.asset(
                  'assets/icons/ship_icon.png',
                  height: 22,
                  width: 30,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jenisKapal,
                    style: TextStyle(
                      color: Color(0xff59597C),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    namaKapal,
                    style: TextStyle(
                      color: Color(0xff59597C),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 27, right: 17),
                child: Image.asset(
                  'assets/icons/date_icon.png',
                  height: 15,
                  width: 15,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    keberangkatan,
                    style: TextStyle(
                      color: Color(0xff59597C),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 27, right: 17),
                child: Image.asset(
                  'assets/icons/location_icon.png',
                  height: 15,
                  width: 15,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    lokasi,
                    style: TextStyle(
                      color: Color(0xff59597C),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
