import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/screen/beranda/component/berita_widget.dart';
import 'package:pelindo_travel/screen/jenis_kapal/jenis_kapal_screen.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({Key key}) : super(key: key);

  @override
  _BerandaScreenState createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  List<String> _kotaAsal = [];
  List<String> _kotaTujuan = [];
  // final Items = ApiService().getData('/ruteAwal');
  String kotaAsal;
  String kotaTujuan;
  String id;
  DateTime tanggalBerangkat;

  final kapalItems = ['Semua', 'PELNI', 'Dharma Lautan Utama'];
  String namaKapal;

  DateTime date = DateTime.now();

  bool dateSelected = false;

  String getDate() {
    tanggalBerangkat = date;
    var dateFormated = DateFormat('EEEE, dd MMM yyyy', 'id');
    if (dateSelected == false) {
      return dateFormated.format(DateTime.now());
    } else {
      return dateFormated.format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  _getRute() async {
    await ApiService().getData("/getRuteAwal").then((response) {
      setState(() {
        List<String> list =
            (jsonDecode(response.body) as List<dynamic>).cast<String>();

        for (String string in list) {
          _kotaAsal.add(string);
        }
      });
    });

    await ApiService().getData("/getRuteAkhir").then((response) {
      setState(() {
        List<String> list =
            (jsonDecode(response.body) as List<dynamic>).cast<String>();

        for (String string in list) {
          _kotaTujuan.add(string);
        }
      });
    });

    EasyLoading.dismiss();
  }

  _initData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    id = localStorage.getString("id");
  }

  _cariKapal() {
    Navigator.pushNamed(
      context,
      '/jenis-kapal',
      arguments: JenisKapalScreen(
          ruteAwal: kotaAsal,
          ruteAkhir: kotaTujuan,
          tglBerangkat: tanggalBerangkat),
    );
  }

  @override
  void initState() {
    super.initState();

    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _initData();
    _getRute();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   shadowColor: Colors.transparent,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              VerticalSpacing(),
              Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(28),
                    right: getProportionateScreenWidth(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Haloo.. \nMau Pergi ke \nmana kali ini?',
                      style: TextStyle(
                        color: Color(0xff59597C),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Arial',
                      ),
                    ),
                    Container(
                      height: getProportionateScreenHeight(142),
                      width: getProportionateScreenWidth(150),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/ship.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(0, -10),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 1,
                        offset: Offset(0, -1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VerticalSpacing(),
                      Text(
                        'Keberangkatan',
                        style: TextStyle(
                          color: Color(0xff2D9CDB),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Arial',
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'KOTA ASAL',
                                  style: TextStyle(
                                    color: Color(0xff2D9CDB),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: getProportionateScreenWidth(145),
                                  padding: EdgeInsets.symmetric(
                                    // vertical: 8,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff979797),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: kotaAsal,
                                      isExpanded: true,
                                      items:
                                          _kotaAsal.map(buildMenuItem).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          this.kotaAsal = value.toString();
                                        });
                                      },
                                      hint: Text(
                                        'Pilih Kota',
                                        style: TextStyle(
                                          color: Color(0xff59597C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Arial',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      icon: Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 22,
                              child: Image(
                                alignment: Alignment.bottomCenter,
                                width: 20,
                                height: 18,
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/icons/arrow_left_right.png'),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'KOTA TUJUAN',
                                  style: TextStyle(
                                    color: Color(0xff2D9CDB),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: getProportionateScreenWidth(145),
                                  padding: EdgeInsets.symmetric(
                                    // vertical: 8,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff979797),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: kotaTujuan,
                                      isExpanded: true,
                                      items: _kotaTujuan
                                          .map(buildMenuItem)
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          this.kotaTujuan = value.toString();
                                        });
                                      },
                                      hint: Text(
                                        'Pilih Kota',
                                        style: TextStyle(
                                          color: Color(0xff59597C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Arial',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      icon: Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(15)),
                        child: Divider(),
                      ),
                      // Row(
                      //   children: [
                      // Expanded(
                      //   child: Padding(
                      //     padding: EdgeInsets.only(
                      //         left: getProportionateScreenWidth(20),
                      //         right: getProportionateScreenWidth(15)),
                      //     child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Tanggal keberangkatan',
                            style: TextStyle(
                              color: Color(0xff2D9CDB),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Arial',
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () {
                              pickDate(context);
                            },
                            child: Container(
                              width: getProportionateScreenWidth(205),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff979797),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  getDate(),
                                  style: TextStyle(
                                    color: Color(0xff59597C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 37,
                      ),
                      TextButton(
                        onPressed: () {
                          if (kotaAsal == null || kotaTujuan == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Kota Asal maupun Kota Tujuan Tidak Boleh Kosong"),
                            ));
                          } else {
                            _cariKapal();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'CARI TIKET',
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
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
              ),
              BeritaWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      locale: const Locale("id", "ID"),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 7),
    );

    if (newDate == null) return;

    setState(() {
      date = newDate;
      tanggalBerangkat = newDate;
      dateSelected = true;
    });
  }
}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(
        color: Color(0xff59597C),
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Arial',
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}
