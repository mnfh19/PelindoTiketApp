import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pelindo_travel/screen/tiket/component/webview_tiket.dart';
import '../../app_color.dart';
import 'dart:io';

import 'dart:ui' as ui;
import 'dart:typed_data';

class DetailTiketScreen extends StatefulWidget {
  final bool tipe, isPenumpang, isKendaraan;
  final String nama,
      km,
      no_tiket,
      penumpang,
      telp_penumpang,
      jumlah,
      tgl_berangkat,
      tgl_tiba,
      kelas,
      kendaraan,
      pemesan,
      telp_pemesan,
      awal,
      akhir;
  const DetailTiketScreen(
      {Key key,
      this.nama,
      this.km,
      this.no_tiket,
      this.penumpang,
      this.telp_penumpang,
      this.jumlah,
      this.tgl_berangkat,
      this.tgl_tiba,
      this.kelas,
      this.kendaraan,
      this.pemesan,
      this.telp_pemesan,
      this.awal,
      this.akhir,
      this.tipe,
      this.isPenumpang,
      this.isKendaraan})
      : super(key: key);

  @override
  _DetailTiketScreenState createState() => _DetailTiketScreenState();
}

class _DetailTiketScreenState extends State<DetailTiketScreen> {
  final GlobalKey _key = GlobalKey();

  void _takeScreenshot() async {
    RenderRepaintBoundary boundary =
        _key.currentContext.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Saving the screenshot to the gallery
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(pngBytes),
          quality: 90,
          name: 'screenshot-${DateTime.now()}.png');
      print(result);
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Tersimpan, Silahkan Cek Gallery Anda"),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _key,
      child: Scaffold(
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
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, left: 16, right: 16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'KAPAL ' +
                          widget.nama.toUpperCase() +
                          ' (' +
                          widget.km.toUpperCase() +
                          ')',
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'NP-116-F- EKO - E',
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 4),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 20),
                child: Text(
                  'Booking Code',
                  style: TextStyle(
                    color: Color(0xff656F77),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              Center(
                child: BarcodeWidget(
                  barcode: Barcode.code128(), // Barcode type and settings
                  data: widget.no_tiket, // Content
                  width: 200,
                  height: 80,
                ),
              ),
              Divider(thickness: 2),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 20),
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
                padding: EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    widget.isPenumpang
                        ? Row(
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ': ' + widget.penumpang,
                                        style: TextStyle(
                                          color: Color(0xff999999),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      widget.tipe
                                          ? Text(
                                              '  (' +
                                                  widget.telp_penumpang +
                                                  ')',
                                              style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                              ),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(0),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            margin: EdgeInsets.all(0),
                          ),
                    SizedBox(height: 5),
                    widget.isPenumpang
                        ? Row(
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
                                    ': ' + widget.jumlah + ' Orang',
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
                          )
                        : Container(
                            margin: EdgeInsets.all(0),
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
                              ': ' + widget.tgl_berangkat,
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
                              ': ' + widget.tgl_tiba,
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
                    widget.isPenumpang
                        ? Row(
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
                                    ': ' + widget.kelas,
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
                          )
                        : Container(
                            margin: EdgeInsets.all(0),
                          ),
                    SizedBox(height: 5),
                    widget.isKendaraan
                        ? Row(
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
                                    ': ' + widget.kendaraan,
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
                          )
                        : Container(
                            margin: EdgeInsets.all(0),
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
                                  ': ' + widget.pemesan,
                                  style: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  '  (' + widget.telp_pemesan + ')',
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
              Divider(thickness: 2),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.awal.toUpperCase(),
                        style: TextStyle(
                          color: Color(0xff2596D7),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: '  >  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: widget.akhir.toUpperCase(),
                        style: TextStyle(
                          color: Color(0xff2596D7),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 4),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                height: 50,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () => _takeScreenshot(),
                  child: Center(
                    child: Text(
                      'Cetak Tiket',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Arial',
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
