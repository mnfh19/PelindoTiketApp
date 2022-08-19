import 'package:flutter/material.dart';
import 'package:pelindo_travel/size_config.dart';

class DataKosong extends StatelessWidget {
  final text;
  const DataKosong({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            height: getProportionateScreenHeight(304),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/riwayat_kosong.png'),
              ),
            ),
          ),
          Spacer(),
          Text(
            text,
            style: TextStyle(
              color: Color(0xff333E63),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
          VerticalSpacing(),
          Text(
            'Tidak Ada Jadwal Kapal Yang Tersedia, Silahkan Cek Ulang Tanggal Atau Tunggu Info Lebih Lanjut',
            style: TextStyle(
              color: Color(0xff333E63),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
              height: 1.9,
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
