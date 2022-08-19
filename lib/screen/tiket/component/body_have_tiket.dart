import 'package:flutter/material.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/models/penumpang.dart';
import 'package:pelindo_travel/screen/ringkasan_pemesanan/component/informasi_kapal.dart';
import 'package:pelindo_travel/screen/tiket/component/data_penumpang_widget.dart';
import 'package:pelindo_travel/screen/tiket/detail_tiket_screen.dart';

import '../../../size_config.dart';

class BodyHaveTiket extends StatelessWidget {
  final String nama,
      km,
      awal,
      akhir,
      lama,
      tgl,
      penumpang,
      kendaraan,
      tgl_awal,
      tgl_akhir,
      jumlah,
      kelas,
      pemesan,
      telp_pemesan;
  final int booking;
  final bool isKendaraan, isPenumpang;
  const BodyHaveTiket({
    Key key,
    this.nama,
    this.km,
    this.tgl,
    this.awal,
    this.akhir,
    this.lama,
    this.isKendaraan,
    this.isPenumpang,
    this.penumpang,
    this.kendaraan,
    this.booking,
    this.tgl_awal,
    this.tgl_akhir,
    this.jumlah,
    this.kelas,
    this.pemesan,
    this.telp_pemesan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Penumpang" + isPenumpang.toString());
    print("Kendaraan" + isKendaraan.toString());

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
        // height: SizeConfig.screenHeight!,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Informasi Kapal',
                style: TextStyle(
                  color: Color(0xff88879C),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            InformasiKapalWidget(
              kotaAsal: awal,
              kotaTujuan: akhir,
              waktu: lama + ' \nLangsung',
              jenisKapal: nama,
              namaKapal: '(' + km + ')',
              keberangkatan: tgl,
              lokasi: 'Surabaya (Pelabuhan Tanjung Perak)',
            ),
            VerticalSpacing(),
            isPenumpang
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Nama Penumpang:',
                          style: TextStyle(
                            color: Color(0xff047C99),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: ApiService().getPenumpangTiket(booking),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Penumpang>> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  "Something wrong with message: ${snapshot.error.toString()}"),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<Penumpang> list = snapshot.data;

                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Penumpang data = list[index];

                                bool isDewasa = true;

                                if (data.jenis_penumpang == "0") {
                                  isDewasa = false;
                                }

                                return DataPenumpangWidget(
                                  namaPenumpang: data.nama_penumpang,
                                  jenisIdentitas: data.jenis_identitas,
                                  nomorIdentitas: data.no_identitas,
                                  press: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/detail-tiket',
                                      arguments: DetailTiketScreen(
                                        nama: nama,
                                        km: km,
                                        no_tiket: data.no_tiket,
                                        penumpang: data.nama_penumpang,
                                        kendaraan: kendaraan,
                                        telp_penumpang: data.telp,
                                        jumlah: jumlah,
                                        tgl_berangkat: tgl_awal,
                                        tgl_tiba: tgl_akhir,
                                        kelas: kelas,
                                        pemesan: pemesan,
                                        telp_pemesan: telp_pemesan,
                                        awal: awal,
                                        akhir: akhir,
                                        tipe: isDewasa,
                                        isKendaraan: isKendaraan,
                                        isPenumpang: isPenumpang,
                                      ),
                                    );
                                  },
                                );
                              },
                              itemCount: list.length,
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  )
                : Container(),
            isKendaraan
                ? isPenumpang
                    ? Container()
                    : Container(
                        margin: EdgeInsets.symmetric(vertical: 18),
                        height: 50,
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/login',
                            );
                          },
                          child: Center(
                            child: Text(
                              'Lihat Tiket Kendaraan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                        ),
                      )
                : Container(),
          ],
        ),
      ),
    );
  }
}
