import 'package:flutter/material.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/models/penumpang.dart';
import 'package:pelindo_travel/screen/riwayat/component/kota_asal_tujuan_widget.dart';

class ModalDetailPemesanan extends StatelessWidget {
  final idBooking,
      awal,
      akhir,
      jumlah,
      berangkat,
      tiba,
      kelas,
      pemesan,
      telp,
      kendaraan;
  const ModalDetailPemesanan({
    Key key,
    this.idBooking,
    this.awal,
    this.akhir,
    this.jumlah,
    this.berangkat,
    this.tiba,
    this.kelas,
    this.pemesan,
    this.telp,
    this.kendaraan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool kend = false;
    if (jumlah == 0) {
      kend = true;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          KotaAsalTujuanWidget(
            kotaAsal: awal,
            kotaTujuan: akhir,
          ),
          SizedBox(height: 17),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Detail Pemesanan: ',
              style: TextStyle(
                color: Color(0xff656F77),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        kend ? "Jenis Kendaraan" : 'Nama Penumpang',
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    kend
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " : " + kendaraan,
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          )
                        : Expanded(
                            child: Container(
                              child: FutureBuilder(
                                future: ApiService().getAllPenumpang(idBooking),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Penumpang>> snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                          "Something wrong with message: ${snapshot.error.toString()}"),
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    List<Penumpang> penumpang = snapshot.data;

                                    return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        Penumpang data = penumpang[index];
                                        var telp;
                                        if (data.telp == null) {
                                          telp = "-";
                                        } else {
                                          telp = data.telp;
                                        }
                                        String dot = " : ";
                                        if (index != 0) {
                                          dot = "   ";
                                        }

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dot + data.nama_penumpang,
                                              style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Text(
                                              '  (' + telp + ')',
                                              style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      itemCount: penumpang.length,
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 5),
                kend
                    ? Container()
                    : Row(
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
                                ': ' + jumlah.toString() + ' Orang',
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
                        'Waktu Berangkat',
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
                          ': ' + berangkat,
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
                        'Waktu Tiba',
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
                          ': ' + tiba,
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
                kend
                    ? Container()
                    : Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text(
                              'Kelas Kapal',
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
                                ': ' + kelas,
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
                        'Nama Pemesan',
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ': ' + pemesan,
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              '  (' + telp + ')',
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
