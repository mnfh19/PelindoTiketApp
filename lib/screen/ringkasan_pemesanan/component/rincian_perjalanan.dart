import 'package:flutter/material.dart';
import 'package:pelindo_travel/widget/currency.dart';

class RincianPerjalanan extends StatelessWidget {
  final namaPenumpang;
  final kelasTiket;
  final jumlahPenumpang;
  final hargaTotal;
  final isKendaraan;
  final isPenumpang;
  final namaKendaraan;
  const RincianPerjalanan({
    Key key,
    this.namaPenumpang,
    this.kelasTiket,
    this.jumlahPenumpang,
    this.hargaTotal,
    this.isKendaraan,
    this.isPenumpang,
    this.namaKendaraan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isPenumpang
            ? Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        'Nama Penumpang',
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ':',
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  namaPenumpang.length,
                                  (index) {
                                    return Text(
                                      ' - ' + namaPenumpang[index].toString(),
                                      style: TextStyle(
                                        color: Color(0xff999999),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.only(bottom: 0),
              ),
        isPenumpang
            ? Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        'Kelas Tiket',
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
                          ': $kelasTiket',
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
              )
            : Container(
                margin: EdgeInsets.only(bottom: 0),
              ),
        isPenumpang
            ? Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
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
              )
            : Container(
                margin: EdgeInsets.only(bottom: 5),
              ),
        isKendaraan
            ? Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        'Jenis Kendaraan',
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
                          ': $namaKendaraan',
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
              )
            : Container(
                margin: EdgeInsets.only(bottom: 5),
              ),
        Row(
          children: [
            Container(
              width: 120,
              child: Text(
                'Harga Total TIket',
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
                  ': ' + CurrencyFormat.convertToIdr(int.parse(hargaTotal), 0),
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
      ],
    );
  }
}
