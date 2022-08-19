import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/models/booking.dart';
import 'package:pelindo_travel/models/user.dart';
import 'package:pelindo_travel/screen/tiket/component/body_belumbayar_tiket.dart';
import 'package:pelindo_travel/screen/tiket/component/body_empty_tiket.dart';
import 'package:pelindo_travel/screen/tiket/component/body_have_tiket.dart';
import 'package:pelindo_travel/widget/body_notlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_color.dart';

class TiketScreen extends StatefulWidget {
  const TiketScreen({Key key}) : super(key: key);

  @override
  _TiketScreenState createState() => _TiketScreenState();
}

class _TiketScreenState extends State<TiketScreen> {
  bool haveTiket = true;
  bool load = true;
  String id, nama, telp;
  String id_booking;

  getId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    if (localStorage.getString("id") != null) {
      setState(() {
        load = false;
        id = localStorage.getString("id");
        var sessUser = localStorage.getString("user");
        var dat = jsonDecode(sessUser);
        User user = User.fromJson(dat[0]);
        nama = user.username;
        telp = user.telp;

        // checkBayar(id);
        // id_booking = localStorage.getString("status_booking");
      });
    }
  }

  @override
  void initState() {
    getId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        shadowColor: Color(0xff85D3FF),
        automaticallyImplyLeading: false,
        title: Text(
          'TIKET',
          style: TextStyle(
            color: Color(0xff181D2D),
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: ApiService().getWhereData("/getStatusBooking", id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        "Something wrong with message: ${snapshot.error.toString()}"),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> dat = jsonDecode(snapshot.data);

                  if (dat['id_booking'] == null) {
                    return BodyEmptyTiket();
                  }

                  var status = dat['status_booking'];
                  bool isKendaraan = false;
                  bool isPenumpang = false;
                  var namaKendaraan;
                  var perKendaraan = 0;

                  if (dat['id_tiket'] != "0") {
                    isPenumpang = true;
                  }

                  if (dat['id_tiket_kendaraan'] != "0") {
                    isKendaraan = true;
                    namaKendaraan = dat['jenis_kendaraan'];
                    perKendaraan = int.parse(dat['harga']);
                  }

                  if (dat['id_tiket'] != "0" && dat['id_tiket_kendaraan'] != "0") {
                    isPenumpang = true;
                    isKendaraan = true;
                    namaKendaraan = dat['jenis_kendaraan'];
                     perKendaraan = int.parse(dat['harga']);
                  }

                  if (status == "3") {
                    return BodyEmptyTiket();
                  }

                  if (status == "5") {
                    return BodyEmptyTiket();
                  }

                  if (status == "0" || status == "1") {
                    var data = {
                      "id_tiket": dat['id_tiket'],
                      "id_tiket_kendaraan": dat['id_tiket_kendaraan'],
                    };

                    var dateFormated =
                        DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id');
                    DateTime tgl_tenggat = new DateFormat("yyyy-MM-dd HH:mm")
                        .parse(dat['tgl_berangkat']+" "+dat['jam_berangkat']);

                    var tenggat = tgl_tenggat.subtract(Duration(hours: 6));

                    var bal = 0;
                    var dew = 0;
                    var jumBal = int.parse(dat['penumpang_balita']);
                    var jumDew = int.parse(dat['penumpang_dewasa']);

                    if (jumBal != 0) {
                      bal = jumBal * int.parse(dat['harga_balita']);
                    }

                    if (jumDew != 0) {
                      dew = jumDew * int.parse(dat['harga_dewasa']);
                    }

                    DateTime now = DateTime.now();
                    DateFormat format_tgl =
                        DateFormat('yyyy-MM-dd HH:mm:ss', 'id');
                    var ta = format_tgl.format(now);

                    bool isTerbayar = false;
                    if (dat["status_bayar"] == "1") {
                      isTerbayar = true;
                    }

                    return BodyBelumBayar(
                      id_booking: dat['id_booking'].toString(),
                      no_rek1: "1260272061",
                      no_rek2: "499201021147535",
                      atas_nama1: "Putri Sri Rahayu",
                      atas_nama2: "Putri Sri Rahayu",
                      dewasa: dew,
                      balita: bal,
                      kendaraan: perKendaraan,
                      isKendaraan: isKendaraan,
                      isPenumpang: isPenumpang,
                      total: dat['harga_total'],
                      tenggat: dateFormated.format(tgl_tenggat),
                      isTerbayar: isTerbayar,
                    );
                  } else {
                    DateTime tgl_awal = new DateFormat("yyyy-MM-dd")
                        .parse(dat['tgl_berangkat'].toString());
                    DateTime tgl_akhir = new DateFormat("yyyy-MM-dd")
                        .parse(dat['tgl_tiba'].toString());
                    DateTime jam_awal = new DateFormat("HH:mm")
                        .parse(dat['jam_berangkat'].toString());
                    DateTime jam_akhir = new DateFormat("HH:mm")
                        .parse(dat['jam_tiba'].toString());
                    DateFormat tglFormat = DateFormat('dd MMM yy', 'id');
                    DateFormat jamFormat = DateFormat('HH:mm', 'id');

                    var t1 = tglFormat.format(tgl_awal).toString();
                    var t2 = tglFormat.format(tgl_akhir).toString();
                    var j1 = jamFormat.format(jam_awal).toString();
                    var j2 = jamFormat.format(jam_akhir).toString();

                    var tgl =
                        t1 + ", " + j1 + " WIB - " + t2 + ", " + j2 + " WIB";

                    var jumlah = int.parse(dat['penumpang_dewasa']) +
                        int.parse(dat['penumpang_balita']);

                    DateFormat tglTiket = DateFormat('dd MMMM yyyy', 'id');
                    DateFormat jamTiket = DateFormat('HH.mm', 'id');

                    var tglBerangkat = tglTiket.format(tgl_awal).toString() +
                        " (" +
                        jamTiket.format(jam_awal).toString() +
                        " WIB)";
                    var tglTiba = tglTiket.format(tgl_akhir).toString() +
                        " (" +
                        jamTiket.format(jam_akhir).toString() +
                        " WIB)";

                    return BodyHaveTiket(
                      awal: dat['rute_awal'],
                      akhir: dat['rute_akhir'],
                      lama: dat['lama_perjalanan'],
                      nama: dat['nama_kapal'],
                      km: dat['KM'],
                      tgl: tgl,
                      // penumpang: dat['id_tiket'].toString(),
                      kendaraan: namaKendaraan,
                      isKendaraan: isKendaraan,
                      isPenumpang: isPenumpang,
                      booking: dat['id_booking'],
                      jumlah: jumlah.toString(),
                      tgl_awal: tglBerangkat,
                      tgl_akhir: tglTiba,
                      kelas: dat['kelas_tiket'],

                      pemesan: nama,
                      telp_pemesan: telp,
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
    );
  }
}
