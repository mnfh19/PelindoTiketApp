import 'package:flutter/material.dart';
import 'package:pelindo_travel/screen/riwayat/component/kota_asal_tujuan_widget.dart';

import '../../../app_color.dart';

class RiwayatItemWidget extends StatelessWidget {
  final kotaAsal;
  final kotaTujuan;
  final waktu;
  final namaKapal;
  final noBooking;
  final tanggalBooking;
  final jumlahPenumpang;
  final press;

  const RiwayatItemWidget({
     Key key,
     this.kotaAsal,
     this.kotaTujuan,
     this.waktu,
     this.namaKapal,
     this.noBooking,
     this.tanggalBooking,
     this.jumlahPenumpang,
     this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20),
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
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    KotaAsalTujuanWidget(
                      kotaAsal: kotaAsal,
                      kotaTujuan: kotaTujuan,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  waktu,
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Arial',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  namaKapal,
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        'No Booking',
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          ': $noBooking',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
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
                      width: 120,
                      child: Text(
                        'Tanggal Booking',
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          ': $tanggalBooking',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        'Jumlah Penumpang',
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          ': $jumlahPenumpang Orang',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: press,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                // width: 150,
                // height: 20,
                decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Detail Pemesanan',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
