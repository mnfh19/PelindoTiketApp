import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/widget/currency.dart';

import '../../../size_config.dart';

class BodyBelumBayar extends StatefulWidget {
  final id_booking;
  final no_rek1;
  final no_rek2;
  final atas_nama1;
  final atas_nama2;
  final dewasa;
  final balita;
  final kendaraan;
  final total;
  final tenggat;
  final isKendaraan;
  final isPenumpang;
  final isTerbayar;
  const BodyBelumBayar(
      {Key key,
      this.no_rek1,
      this.no_rek2,
      this.atas_nama1,
      this.atas_nama2,
      this.dewasa,
      this.balita,
      this.kendaraan,
      this.total,
      this.tenggat,
      this.isKendaraan,
      this.isPenumpang,
      this.isTerbayar,
      this.id_booking})
      : super(key: key);

  @override
  _BodyBelumBayarState createState() => _BodyBelumBayarState();
}

class _BodyBelumBayarState extends State<BodyBelumBayar> {
  File _image;

  _imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
      // _image = image;
    });
  }

  _imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
      // _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _lihatGambar() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              title: Text('Upload Bukti Pembayaran'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: Card(
                      elevation: 3,
                      child: _image != null
                          ? ClipRRect(
                              child: Image.file(
                                _image,
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(),
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                  Text("Tekan untuk pilih gambar")
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    // width: 150,
                    // height: 20,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Refresh',
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    EasyLoading.show(
                      status: 'loading...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    ApiService()
                        .upload(_image.path, "/accPembayaran")
                        .then((response) async {
                      if (response == "Gagal") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: new Text(
                                "Terjadi Kesalahan, Silahkan Coba Lagi")));
                      } else {
                        print(widget.id_booking);
                        var ubahdata = {
                          'id_booking': widget.id_booking,
                          'bukti': response,
                        };
                        print(response);

                        await ApiService()
                            .postData(ubahdata, "/setPembayaran")
                            .then((response) {
                          var body = json.decode(response.body);
                          print(body);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: new Text(body['msg'])));

                          EasyLoading.dismiss();
                          setState(() {});
                        });
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    // width: 150,
                    // height: 20,
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Upload Bukti Pembayaran',
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(),
              Text(
                'Sebelum konfirmasi transfer, silahkan transfer uang sesuai nominal total bayar ke salah satu rekening dibawah ini :',
                style: TextStyle(
                  color: Color(0xff047C99),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image(
                            height: 50,
                            width: 130,
                            image: AssetImage('assets/images/bni.png'),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10, right: 4),
                            padding:
                                EdgeInsets.only(left: 5, top: 10, bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xff656F77),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  child: Text(
                                    'No.Rekening ',
                                    style: TextStyle(
                                      color: Color(0xff047C99),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.no_rek1,
                                  style: TextStyle(
                                    color: Color(0xff047C99),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 60,
                                  child: Text(
                                    'Atas Nama ',
                                    style: TextStyle(
                                      color: Color(0xff047C99),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.atas_nama1,
                                  style: TextStyle(
                                    color: Color(0xff047C99),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image(
                            height: 50,
                            width: 100,
                            image: AssetImage('assets/images/bri.png'),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10, left: 4),
                            padding:
                                EdgeInsets.only(left: 5, top: 10, bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xff656F77),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  child: Text(
                                    'No.Rekening ',
                                    style: TextStyle(
                                      color: Color(0xff047C99),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.no_rek2,
                                  style: TextStyle(
                                    color: Color(0xff047C99),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 60,
                                  child: Text(
                                    'Atas Nama ',
                                    style: TextStyle(
                                      color: Color(0xff047C99),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.atas_nama2,
                                  style: TextStyle(
                                    color: Color(0xff047C99),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpacing(),
              Text(
                'Rincian Harga',
                style: TextStyle(
                  color: Color(0xff88879C),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Arial',
                ),
              ),
              VerticalSpacing(),
              widget.isPenumpang
                  ? Container(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              'Dewasa',
                              style: TextStyle(
                                color: Color(0xff88879C),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
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
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              CurrencyFormat.convertToIdr(widget.dewasa, 0),
                              style: TextStyle(
                                color: Color(0xff88879C),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(0),
                    ),
              widget.isPenumpang
                  ? Container(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              'Balita',
                              style: TextStyle(
                                color: Color(0xff88879C),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
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
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              CurrencyFormat.convertToIdr(widget.balita, 0),
                              style: TextStyle(
                                color: Color(0xff88879C),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(0),
                    ),
              widget.isKendaraan
                  ? Container(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              'Kendaraan',
                              style: TextStyle(
                                color: Color(0xff88879C),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
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
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              CurrencyFormat.convertToIdr(widget.kendaraan, 0),
                              style: TextStyle(
                                color: Color(0xff88879C),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(0),
                    ),
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 5),
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
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'TOTAL HARGA',
                        style: TextStyle(
                          color: Color(0xff88879C),
                          fontSize: 13,
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
                        CurrencyFormat.convertToIdr(int.parse(widget.total), 0),
                        style: TextStyle(
                          color: Color(0xff88879C),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpacing(),
              widget.isTerbayar
                  ? Center(
                      child: Text(
                        'Menunggu Konfirmasi Admin ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffF35320),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            height: 1.9),
                      ),
                    )
                  : RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Mohon Melakukan Pembayaran Sebesar ',
                            style: TextStyle(
                                color: Color(0xffF35320),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                height: 1.9),
                          ),
                          TextSpan(
                            text: CurrencyFormat.convertToIdr(
                                int.parse(widget.total), 0),
                            style: TextStyle(
                                color: Color(0xffF35320),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                height: 1.9),
                          ),
                          TextSpan(
                            text: ' sebelum ' + widget.tenggat + ' WIB',
                            style: TextStyle(
                                color: Color(0xffF35320),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                height: 1.9),
                          ),
                        ],
                      ),
                    ),
              widget.isTerbayar
                  ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BatalmodalDialog(
                                booking: widget.id_booking,
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            // Color(0xff979797).withOpacity(0.57),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Batalkan Pesanan',
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
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BatalmodalDialog(
                                      booking: widget.id_booking,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 250,
                                decoration: BoxDecoration(
                                  color:
                                      // colorPrimary,
                                      Color(0xff979797).withOpacity(0.57),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'BATALKAN',
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
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: TextButton(
                              onPressed: () => _lihatGambar(),
                              child: Container(
                                height: 50,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: colorPrimary,
                                  // Color(0xff979797).withOpacity(0.57),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Upload Bukti \nPembayaran',
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
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class BatalmodalDialog extends StatelessWidget {
  final booking;
  const BatalmodalDialog({
    Key key,
    this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        // width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(25), vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Batalkan Pemesanan',
              style: TextStyle(
                // color: Color(0xff181D2D),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 37,
            ),
            Text(
              'Apakah Anda Yakin Ingin \nMembatalkan pesanan anda?',
              style: TextStyle(
                // color: Color(0xff181D2D),
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xff88879C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    EasyLoading.show(
                      status: 'loading...',
                      maskType: EasyLoadingMaskType.black,
                    );

                    await ApiService()
                        .getData("/setBatal/" + booking)
                        .then((response) {
                          print(response);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              new Text("Pemesanan Tiket Berhasil Dibatalkan")));

                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);

                      EasyLoading.dismiss();
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
