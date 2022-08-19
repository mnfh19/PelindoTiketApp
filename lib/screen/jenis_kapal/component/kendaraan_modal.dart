import 'package:flutter/material.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/models/tiket_kendaraan.dart';
import 'package:pelindo_travel/widget/currency.dart';

import '../../../size_config.dart';

class ModalKendaraan extends StatelessWidget {
  final String id;
  const ModalKendaraan({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10), vertical: 13),
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
              'Kendaraan',
              style: TextStyle(
                color: Color(0xffD46308),
                fontSize: 16,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          FutureBuilder(
            future: ApiService().getTiketKendaraan(id),
            builder: (BuildContext context,
                AsyncSnapshot<List<TiketKendaraan>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "Something wrong with message: ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<TiketKendaraan> jadwal = snapshot.data;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    TiketKendaraan data = jadwal[index];
                    var harga = int.parse(data.harga);

                    return HargaKendaraan(
                      namaKelas: data.jenis_kendaraan,
                      harga: CurrencyFormat.convertToIdr(harga, 0),
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

class HargaKendaraan extends StatelessWidget {
  final namaKelas;
  final harga;
  const HargaKendaraan({
    Key key,
    this.namaKelas,
    this.harga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only(
          top: 13,
          bottom: 13,
          left: getProportionateScreenWidth(12),
          right: getProportionateScreenWidth(5)),
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
        children: [
          Expanded(
            child: Text(
              namaKelas,
              style: TextStyle(
                color: Color(0xff59597C),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
              maxLines: 2,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  ':',
                  style: TextStyle(
                    color: Color(0xff59597C),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  '\t\t\t',
                  style: TextStyle(
                    color: Color(0xff59597C),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  '$harga',
                  style: TextStyle(
                    color: Color(0xff59597C),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
