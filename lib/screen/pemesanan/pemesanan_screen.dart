import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/models/tiket_kendaraan.dart';
import 'package:pelindo_travel/models/tiket_penumpang.dart';
import 'package:pelindo_travel/screen/data_penumpang/input_penumpang_screen.dart';
import 'package:pelindo_travel/screen/pemesanan/component/jumlah_tiket_field.dart';
import 'package:pelindo_travel/screen/pemesanan/component/modal_kelas_kapal.dart';
import 'package:pelindo_travel/screen/pemesanan/component/modal_pilih_kendaraan.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:pelindo_travel/widget/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_color.dart';

class PemesananScreen extends StatefulWidget {
  final String id;
  final String namaKapal;
  final String id_jadwal;
  final bool isKendaraan;
  final bool isPenumpang;
  const PemesananScreen(
      {Key key,
      this.id,
      this.namaKapal,
      this.id_jadwal,
      this.isKendaraan,
      this.isPenumpang})
      : super(key: key);

  @override
  _PemesananScreenState createState() => _PemesananScreenState();
}

class _PemesananScreenState extends State<PemesananScreen> {
  TextEditingController _jmlDewasa = TextEditingController(text: '0');
  TextEditingController _jmlBayi = TextEditingController(text: '0');

  ModalPenumpang penumpang;

  var kapalItem;
  String namaKelas = 'Pilih Jenis Kelas Tiket';
  var hargaKelasBayi = 0;
  var hargaKelasDewasa = 0;

  String namaKendaraan = 'Pilih Jenis Kelas Kendaraan';
  var hargaKendaraan = 0;

  var idTiket = 0;
  var idKendaraan = 0;

  refresh() {
    setState(() {});
  }

  getTotalHarga() {
    var totalHarga = (hargaKelasDewasa * int.parse(_jmlDewasa.text)) +
        (hargaKelasBayi * int.parse(_jmlBayi.text)) +
        hargaKendaraan;

    return totalHarga;
  }

  @override
  void initState() {
    super.initState();

    // penumpang = ModalPenumpang(this.update);

    print("penumpang" +
        widget.isPenumpang.toString() +
        " kendaran" +
        widget.isKendaraan.toString());
  }

  void updateHargaPenumpang(id, nama, balita, dewasa) {
    setState(() {
      idTiket = id;
      namaKelas = nama;
      hargaKelasBayi = balita;
      hargaKelasDewasa = dewasa;
    });
  }

  void updateHargaKendaraan(id, nama, harga) {
    setState(() {
      idKendaraan = id;
      namaKendaraan = nama;
      hargaKendaraan = harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          'Pemesanan',
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
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(57)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  //nama Kapal
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Nama Kapal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffE8E8E8), width: 1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.namaKapal,
                      style: TextStyle(
                        color: Color(0xff59597C),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 20),
                  //jumlah tiket
                  widget.isPenumpang
                      ? Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Dewasa',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: JumlahTiketField(
                                        textController: _jmlDewasa,
                                        refreshState: refresh,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Bayi (0-23 Bulan)',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: JumlahTiketField(
                                        textController: _jmlBayi,
                                        refreshState: refresh,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: 0),
                        ),

                  //kelas Tiket
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Kelas Tiket',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),

                  InkWell(
                    onTap: () {
                      if (widget.isPenumpang) {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(45),
                                  vertical: 21),
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
                                      'Kelas ' + widget.namaKapal,
                                      style: TextStyle(
                                        color: Color(0xffD46308),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: ApiService()
                                        .getTiketPenumpang(widget.id_jadwal),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<TiketPenumpang>>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              "Something wrong with message: ${snapshot.error.toString()}"),
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        List<TiketPenumpang> jadwal =
                                            snapshot.data;

                                        return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            TiketPenumpang data = jadwal[index];
                                            var balita =
                                                int.parse(data.harga_balita);
                                            var dewasa =
                                                int.parse(data.harga_dewasa);
                                            return ModalPenumpang(
                                              idTiket: data.id_tiket,
                                              namaKelas: data.kelas_tiket,
                                              hargaBayi: balita,
                                              hargaDewasa: dewasa,
                                              update: this.updateHargaPenumpang,
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
                          },
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffE8E8E8), width: 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: widget.isPenumpang
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  namaKelas,
                                  style: TextStyle(
                                    color: Color(0xff88879C),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xff88879C),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    // border: Border.all(
                                    //     color: Color(0xffCCD2E3), width: 2),
                                    image: DecorationImage(
                                      // fit: BoxFit.fill,
                                      image:
                                          AssetImage('assets/icons/info.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Kelas Penumpang pada Kapal ini tidak tersedia ',
                                  style: TextStyle(
                                    color: Color(0xff88879C),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //Jenis Kendaraan
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Jenis Kendaraan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.isKendaraan) {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10),
                                  vertical: 13),
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
                                    future: ApiService()
                                        .getTiketKendaraan(widget.id_jadwal),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<TiketKendaraan>>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              "Something wrong with message: ${snapshot.error.toString()}"),
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        List<TiketKendaraan> jadwal =
                                            snapshot.data;

                                        return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            TiketKendaraan data = jadwal[index];
                                            var harga = int.parse(data.harga);

                                            return ModalKendaraanPesan(
                                              id: data.id_tiket_kendaraan,
                                              namaKendaraan:
                                                  data.jenis_kendaraan,
                                              harga: harga,
                                              update: this.updateHargaKendaraan,
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
                          },
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffE8E8E8), width: 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: widget.isKendaraan
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  namaKendaraan,
                                  style: TextStyle(
                                    color: Color(0xff88879C),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xff88879C),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/icons/info.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Jenis Kendaraan pada Kapal ini tidak tersedia ',
                                  style: TextStyle(
                                    color: Color(0xff88879C),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                  VerticalSpacing(),
                  //Total Pemesanan
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Total Pemesanan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 15, top: 15, bottom: 15, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffE8E8E8), width: 1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                'Dewasa',
                                style: TextStyle(
                                  color: Color(0xff88879C),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "(" + _jmlDewasa.text + ")",
                                  style: TextStyle(
                                    color: Color(0xff88879C),
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                _jmlDewasa.text == '0'
                                    ? 'Rp 0'
                                    : CurrencyFormat.convertToIdr(
                                        int.parse(_jmlDewasa.text) *
                                            hargaKelasDewasa,
                                        0),
                                style: TextStyle(
                                  color: Color(0xff88879C),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                'Bayi',
                                style: TextStyle(
                                  color: Color(0xff88879C),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "(" + _jmlBayi.text + ")",
                                  style: TextStyle(
                                    color: Color(0xff88879C),
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                _jmlBayi.text == '0'
                                    ? 'Rp 0'
                                    : CurrencyFormat.convertToIdr(
                                        int.parse(_jmlBayi.text) *
                                            hargaKelasBayi,
                                        0),
                                style: TextStyle(
                                  color: Color(0xff88879C),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                'Kendaraan',
                                style: TextStyle(
                                  color: Color(0xff88879C),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    color: Color(0xff88879C),
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                hargaKendaraan == 0
                                    ? 'Rp 0'
                                    : CurrencyFormat.convertToIdr(
                                        hargaKendaraan, 0),
                                style: TextStyle(
                                  color: Color(0xff88879C),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                'TOTAL HARGA',
                                style: TextStyle(
                                  color: Color(0xff88879C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                CurrencyFormat.convertToIdr(getTotalHarga(), 0),
                                style: TextStyle(
                                  color: Color(0xff88879C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacing(),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                  right: getProportionateScreenWidth(43), bottom: 20),
              child: TextButton(
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();

                  if (widget.isKendaraan == true &&
                      widget.isPenumpang == false) {
                    print("pesan: kendaraan");
                    await ApiService()
                        .getWhere("/getKapalJadwal", widget.id_jadwal)
                        .then((response) async {
                      Navigator.pushNamed(
                        context,
                        '/input-penumpang',
                        arguments: InputPenumpangScreen(
                          id: sharedPreferences.getString("id"),
                          jadwal: response.body,
                          dewasa: int.parse(_jmlDewasa.text),
                          balita: int.parse(_jmlBayi.text),
                          idTiket: idTiket,
                          idKendaraan: idKendaraan,
                          total: getTotalHarga(),
                          kelas: namaKelas,
                          namaKendaraan: "kosong",
                        ),
                      );
                    });
                  } else if (widget.isKendaraan == false &&
                      widget.isPenumpang == true) {
                    print("pesan: penumpang");
                    await ApiService()
                        .getWhere("/getKapalJadwal", widget.id_jadwal)
                        .then((response) async {
                      Navigator.pushNamed(
                        context,
                        '/input-penumpang',
                        arguments: InputPenumpangScreen(
                          id: sharedPreferences.getString("id"),
                          jadwal: response.body,
                          dewasa: int.parse(_jmlDewasa.text),
                          balita: int.parse(_jmlBayi.text),
                          idTiket: idTiket,
                          idKendaraan: idKendaraan,
                          total: getTotalHarga(),
                          kelas: namaKelas,
                          namaKendaraan: "kosong",
                        ),
                      );
                    });
                  } else {
                    print("pesan: both");
                    await ApiService()
                        .getWhere("/getKapalJadwal", widget.id_jadwal)
                        .then((response) async {
                      Navigator.pushNamed(
                        context,
                        '/input-penumpang',
                        arguments: InputPenumpangScreen(
                          id: sharedPreferences.getString("id"),
                          jadwal: response.body,
                          dewasa: int.parse(_jmlDewasa.text),
                          balita: int.parse(_jmlBayi.text),
                          idTiket: idTiket,
                          idKendaraan: idKendaraan,
                          total: getTotalHarga(),
                          kelas: namaKelas,
                          namaKendaraan: namaKendaraan,
                        ),
                      );
                    });
                  }
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
    );
  }
}

class ModalPenumpang extends StatelessWidget {
  final idTiket;
  final namaKelas;
  final hargaBayi;
  final hargaDewasa;
  final Function update;
  // final ValueChanged<int> setHargaPenum;
  const ModalPenumpang({
    Key key,
    this.idTiket,
    this.namaKelas,
    this.hargaBayi,
    this.hargaDewasa,
    this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        update(idTiket, namaKelas, hargaBayi, hargaDewasa);
      },
      child: Container(
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
            Text(
              'Bayi \n' + CurrencyFormat.convertToIdr(hargaBayi, 0),
              style: TextStyle(
                color: Color(0xff979797),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'Arial',
              ),
            ),
            Text(
              'Dewasa \n' + CurrencyFormat.convertToIdr(hargaDewasa, 0),
              style: TextStyle(
                color: Color(0xff979797),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'Arial',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalKendaraanPesan extends StatelessWidget {
  final id;
  final namaKendaraan;
  final harga;
  final Function update;
  const ModalKendaraanPesan({
    Key key,
    this.id,
    this.namaKendaraan,
    this.harga,
    this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        update(id, namaKendaraan, harga);
      },
      child: Container(
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
                namaKendaraan,
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
                    CurrencyFormat.convertToIdr(harga, 0),
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
      ),
    );
  }
}
