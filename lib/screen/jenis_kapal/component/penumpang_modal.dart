import 'package:flutter/material.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/models/jadwal.dart';
import 'package:pelindo_travel/models/tiket_penumpang.dart';
import 'package:pelindo_travel/widget/currency.dart';

import '../../../size_config.dart';

class ModalKelasPenumpang extends StatelessWidget {
  final String id;
  final String nama;

  const ModalKelasPenumpang({
    Key key,
    this.id,
    this.nama,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(45), vertical: 21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              'Kelas ' + nama,
              style: TextStyle(
                color: Color(0xffD46308),
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          FutureBuilder(
            future: ApiService().getTiketPenumpang(id),
            builder: (BuildContext context,
                AsyncSnapshot<List<TiketPenumpang>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "Something wrong with message: ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<TiketPenumpang> jadwal = snapshot.data;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    TiketPenumpang data = jadwal[index];
                    var balita = int.parse(data.harga_balita);
                    var dewasa = int.parse(data.harga_dewasa);
                    return HargaKapalPelni(
                      namaKelas: data.kelas_tiket,
                      hargaBayi: CurrencyFormat.convertToIdr(balita, 0),
                      hargaDewasa: CurrencyFormat.convertToIdr(dewasa, 0),
                    );
                  },
                  itemCount: jadwal.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          
        ],
      ),
    );
 
  }
}

class HargaKapalPelni extends StatelessWidget {
  final namaKelas;
  final hargaBayi;
  final hargaDewasa;
  const HargaKapalPelni({
    Key key,
    this.namaKelas,
    this.hargaBayi,
    this.hargaDewasa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(
          top: 14,
          bottom: 14,
          left: getProportionateScreenWidth(19),
          right: getProportionateScreenWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xffE8E8E8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            namaKelas,
            style: TextStyle(
              color: Color(0xff59597C),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            " : ",
            style: TextStyle(
              color: Color(0xff59597C),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),

          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          Text(
            'Bayi \n$hargaBayi',
            style: TextStyle(
              color: Color(0xff979797),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'Arial',
            ),
          ),
          Text(
            'Dewasa \n$hargaDewasa',
            style: TextStyle(
              color: Color(0xff979797),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'Arial',
              //     ),
              //   ),
              // ],
            ),
          ),
        ],
      ),
    );
  }
}
