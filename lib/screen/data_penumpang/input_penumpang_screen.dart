import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/models/booking.dart';
import 'package:pelindo_travel/screen/data_penumpang/component/bayi_data.dart';
import 'package:pelindo_travel/screen/data_penumpang/component/dewasa_data.dart';
import 'package:pelindo_travel/screen/ringkasan_pemesanan/ringkasan_pemesanan_screen.dart';

import '../../size_config.dart';

class InputPenumpangScreen extends StatefulWidget {
  final String id;
  final jadwal;
  final int dewasa;
  final int balita;
  final int idTiket;
  final int idKendaraan;
  final int total;
  final String kelas;
  final String namaKendaraan;

  const InputPenumpangScreen({
    Key key,
    this.id,
    this.dewasa,
    this.balita,
    this.idTiket,
    this.idKendaraan,
    this.total,
    this.jadwal,
    this.kelas,
    this.namaKendaraan,
  }) : super(key: key);

  @override
  _InputPenumpangScreenState createState() => _InputPenumpangScreenState();
}

class _InputPenumpangScreenState extends State<InputPenumpangScreen> {
  bool isChecked = false;
  bool balita = false;
  DateFormat format_tgl = DateFormat('yyyy-MM-dd HH:mm:ss', 'id');
  List listPenum = [];

  @override
  void initState() {
    if (widget.balita > 0) {
      balita = true;
    }

    listPenum.clear();

    super.initState();
  }

  update(nama) {
    listPenum.add(nama);
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
          'Input Data Penumpang',
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Image(
                    width: 20,
                    height: 20,
                    image: AssetImage(
                      'assets/icons/users.png',
                    ),
                  ),
                  // SvgPicture.asset('assets/icons/users.svg',
                  //     width: 20, height: 20),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Detail Penumpang',
                    style: TextStyle(
                      color: Color(0xff333E63),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
            ),
            DewasaData(id: widget.id, jum: widget.dewasa, update: this.update),
            balita
                ? BayiData(
                    id: widget.id, jum: widget.balita, update: this.update)
                : Container(),
            VerticalSpacing(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -15),
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 23),
                    child: Text(
                      'Dengan ini saya setuju dan mematuhi pesyaratan dan ketentuan reservasi dari PT. Pelabuhan Indonesia ( persero ), termasuk permbayaran dan mematuhi semua aturan dan pembatasan mengenai ketersediaan tarif atau jasa.',
                      style: TextStyle(
                        color: Color(0xff9F9FB9),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                  right: getProportionateScreenWidth(20), bottom: 20),
              child: TextButton(
                onPressed: () {
                  Booking booking = Booking(
                    id_tiket: widget.idTiket,
                    id_tiket_kendaraan: widget.idKendaraan,
                    id_user: int.parse(widget.id),
                    penumpang_dewasa: widget.dewasa.toString(),
                    penumpang_balita: widget.balita.toString(),
                    harga_total: widget.total.toString(),
                  );

                  if (widget.dewasa == 0) {
                    listPenum = [];
                  }

                  Navigator.pushNamed(
                    context,
                    '/ringkasan-pemesanan',
                    arguments: RingkasanPesananScreen(
                      list: listPenum,
                      booking: booking,
                      jadwal: widget.jadwal,
                      kelas: widget.kelas,
                      kendaraan: widget.namaKendaraan,
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 140,
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'LANJUT',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        backgroundColor: colorPrimary,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
