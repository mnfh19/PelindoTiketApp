import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/models/booking.dart';
import 'package:pelindo_travel/models/user.dart';
import 'package:pelindo_travel/screen/pembayaran/pembayaran_screen.dart';
import 'package:pelindo_travel/screen/ringkasan_pemesanan/component/informasi_kapal.dart';
import 'package:pelindo_travel/screen/ringkasan_pemesanan/component/rincian_pemesan.dart';
import 'package:pelindo_travel/screen/ringkasan_pemesanan/component/rincian_perjalanan.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RingkasanPesananScreen extends StatefulWidget {
  final list;
  final jadwal;
  final kelas;
  final kendaraan;
  final Booking booking;
  const RingkasanPesananScreen(
      {Key key,
      this.list,
      this.booking,
      this.jadwal,
      this.kelas,
      this.kendaraan})
      : super(key: key);

  @override
  _RingkasanPesananScreenState createState() => _RingkasanPesananScreenState();
}

class _RingkasanPesananScreenState extends State<RingkasanPesananScreen> {
  String rute_awal;
  String rute_akhir;
  String lama;
  String nama_kapal;
  String km;
  String tgl;

  String pemesan;
  String email;
  String telp;

  String jumlahPenumpang;

  bool isKendaraan = false;
  bool isPenumpang = false;

  getId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    if (localStorage.getString("id") != null) {
      setState(() {
        var sessUser = localStorage.getString("user");
        var dat = jsonDecode(sessUser);
        User user = User.fromJson(dat[0]);

        pemesan = user.username;
        email = user.email;
        telp = user.telp;

        var jum = int.parse(widget.booking.penumpang_dewasa) +
            int.parse(widget.booking.penumpang_balita);
        jumlahPenumpang = jum.toString();
      });
    }
  }

  getJadwal() {
    Map<String, dynamic> dat = jsonDecode(widget.jadwal);

    DateTime tgl_awal =
        new DateFormat("yyyy-MM-dd").parse(dat['tgl_berangkat'].toString());
    DateTime tgl_akhir =
        new DateFormat("yyyy-MM-dd").parse(dat['tgl_tiba'].toString());
    DateTime jam_awal =
        new DateFormat("HH:mm").parse(dat['jam_berangkat'].toString());
    DateTime jam_akhir =
        new DateFormat("HH:mm").parse(dat['jam_tiba'].toString());
    DateFormat tglFormat = DateFormat('dd MMM yy', 'id');
    DateFormat jamFormat = DateFormat('HH:mm', 'id');

    var t1 = tglFormat.format(tgl_awal).toString();
    var t2 = tglFormat.format(tgl_akhir).toString();
    var j1 = jamFormat.format(jam_awal).toString();
    var j2 = jamFormat.format(jam_akhir).toString();

    tgl = t1 + ", " + j1 + " WIB - " + t2 + ", " + j2 + " WIB";
    rute_awal = dat['rute_awal'];
    rute_akhir = dat['rute_akhir'];
    lama = dat['lama_perjalanan'];
    nama_kapal = dat['nama_kapal'];
    km = dat['KM'];

    if (widget.booking.id_tiket != 0) {
      isPenumpang = true;
    }

    if (widget.booking.id_tiket_kendaraan != 0) {
      isKendaraan = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    // print(bookingToJson(widget.booking));

    // widget.booking.tgl_booking = "asd";

    // print(bookingToJson(widget.booking));

    getId();
    getJadwal();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff85D3FF),
        shadowColor: Color(0xff85D3FF),
        automaticallyImplyLeading: false,
        leadingWidth: 25,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff333E63),
          ),
        ),
        title: Text(
          'Ringkasan Pemesanan',
          style: TextStyle(
            color: Color(0xff181D2D),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi Kapal',
                style: TextStyle(
                  color: Color(0xff88879C),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
              ),
              VerticalSpacing(),
              InformasiKapalWidget(
                kotaAsal: rute_awal,
                kotaTujuan: rute_akhir,
                waktu: lama + ' \nLangsung',
                jenisKapal: 'Kapal ' + nama_kapal,
                namaKapal: '(' + km + ')',
                keberangkatan: tgl,
                lokasi: 'Surabaya (Pelabuhan Tanjung Perak)',
              ),
              VerticalSpacing(),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Rincian Pemesan:',
                  style: TextStyle(
                    color: Color(0xff047C99),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              RincianPemesanWidget(
                namaPemesan: pemesan,
                emailPemesan: email,
                noHpPemesan: telp,
              ),
              VerticalSpacing(),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Rincian Perjalanan:',
                  style: TextStyle(
                    color: Color(0xff047C99),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              RincianPerjalanan(
                namaPenumpang: widget.list,
                kelasTiket: widget.kelas,
                jumlahPenumpang: jumlahPenumpang,
                hargaTotal: widget.booking.harga_total,
                namaKendaraan: widget.kendaraan,
                isKendaraan: isKendaraan,
                isPenumpang: isPenumpang,
              ),
              VerticalSpacing(),
              VerticalSpacing(),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      EasyLoading.show(
                        status: 'Memproses Pesanan...',
                        maskType: EasyLoadingMaskType.black,
                      );

                      var data = {
                        "id_tiket": widget.booking.id_tiket,
                        "id_tiket_kendaraan": widget.booking.id_tiket_kendaraan,
                      };

                      var res =
                          await ApiService().postData(data, '/getPembayaran');
                      var body = json.decode(res.body);

                      var dateFormated =
                          DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id');
                      DateTime tgl_tenggat = new DateFormat("yyyy-MM-dd HH:mm")
                          .parse(body['tenggat'].toString());

                      var bal = 0;
                      var dew = 0;
                      var jumBal = int.parse(widget.booking.penumpang_balita);
                      var jumDew = int.parse(widget.booking.penumpang_dewasa);
                      if (jumBal != 0) {
                        bal = jumBal * int.parse(body['balita']);
                      }

                      if (jumDew != 0) {
                        dew = jumDew * int.parse(body['dewasa']);
                      }

                      DateTime now = DateTime.now();
                      DateFormat format_tgl =
                          DateFormat('yyyy-MM-dd HH:mm:ss', 'id');
                      var ta = format_tgl.format(now);

                      widget.booking.tgl_booking = ta;

                      await ApiService()
                          .bookingBaru2(widget.booking)
                          .then((response) async {
                        var body = json.decode(response.body);

                        if (body['respon']) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => PembayaranScreen(
                                        no_rek1: "1260272061",
                                        no_rek2: "499201021147535",
                                        atas_nama1: "Putri Sri Rahayu",
                                        atas_nama2: "Putri Sri Rahayu",
                                        dewasa: dew,
                                        balita: bal,
                                        kendaraan: body['kendaraan'],
                                        isKendaraan: isKendaraan,
                                        isPenumpang: isPenumpang,
                                        total: widget.booking.harga_total,
                                        tenggat:
                                            dateFormated.format(tgl_tenggat),
                                        idBooking: body['booking'],
                                      )),
                              ModalRoute.withName('/home'));
                          EasyLoading.dismiss();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Terjadi Kesalahan, silahkan coba lagi"),
                          ));
                        }
                      });
                    },
                    child: Center(
                      child: Text(
                        'LANJUTKAN PEMBAYARAN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
