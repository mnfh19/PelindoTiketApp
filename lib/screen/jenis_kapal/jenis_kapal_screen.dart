import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/models/jadwal.dart';
import 'package:pelindo_travel/screen/jenis_kapal/component/date_tab_widget.dart';
import 'package:pelindo_travel/screen/jenis_kapal/component/kapal_dlu_modal.dart';
import 'package:pelindo_travel/screen/jenis_kapal/component/penumpang_modal.dart';
import 'package:pelindo_travel/screen/jenis_kapal/component/kendaraan_modal.dart';
import 'package:pelindo_travel/screen/jenis_kapal/component/orange_dropdown_button.dart';
import 'package:pelindo_travel/screen/jenis_kapal/component/pesan_button.dart';
import 'package:pelindo_travel/screen/pemesanan/pemesanan_screen.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:pelindo_travel/widget/data_kosong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';

class JenisKapalScreen extends StatefulWidget {
  final String ruteAwal;
  final String ruteAkhir;
  final DateTime tglBerangkat;
  const JenisKapalScreen(
      {Key key, this.ruteAwal, this.ruteAkhir, this.tglBerangkat})
      : super(key: key);

  @override
  _JenisKapalScreenState createState() => _JenisKapalScreenState();
}

class _JenisKapalScreenState extends State<JenisKapalScreen> {
  String angka1, angka2, angka3, angka4, angka5;
  String huruf1, huruf2, huruf3, huruf4, huruf5;
  String tglBerangkat;
  ApiService apiService;

  String _selectedSort;
  int _indexSort = 0;
  final List<RadioGroup> _listSort = [
    RadioGroup(index: 0, text: 'Semua Kapal'),
    RadioGroup(index: 1, text: 'PELNI'),
    RadioGroup(index: 2, text: 'Dharma Lautan Utama (DLU)'),
    RadioGroup(index: 3, text: 'Damai Lautan Nusantara (DLN)'),
  ];

  setDate() {
    var angka = DateFormat('dd', 'id');
    var tanggal = DateFormat('yyyy-MM-dd', 'id');
    var huruf = DateFormat('EEE', 'id');

    var berangkat = widget.tglBerangkat;

    var tgl1 = berangkat.subtract(Duration(days: 2));
    var tgl2 = berangkat.subtract(Duration(days: 1));
    var tgl3 = berangkat;
    var tgl4 = berangkat.add(Duration(days: 1));
    var tgl5 = berangkat.add(Duration(days: 2));

    angka1 = angka.format(tgl1);
    angka2 = angka.format(tgl2);
    angka3 = angka.format(tgl3);
    angka4 = angka.format(tgl4);
    angka5 = angka.format(tgl5);

    huruf1 = huruf.format(tgl1);
    huruf2 = huruf.format(tgl2);
    huruf3 = huruf.format(tgl3);
    huruf4 = huruf.format(tgl4);
    huruf5 = huruf.format(tgl5);

    tglBerangkat = tanggal.format(berangkat).toString();
  }

  _getData() async {
    var data = {
      'awal': widget.ruteAwal,
      'akhir': widget.ruteAkhir,
      'tgl': tglBerangkat,
    };
    print(data);

    // var res = await apiService.getData("/getRuteAkhir/"+widget.ruteAwal+"/"+widget.ruteAkhir+"/"+tglBerangkat);
    // await ApiService().getJadwal(data, "/kapalWhereRute").then((response) {
    //   setState(() {
    //     print(response);
    //   });
    // });
  }

  @override
  void initState() {
    setDate();
    _getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var data = {
      'awal': widget.ruteAwal,
      'akhir': widget.ruteAkhir,
      'tgl': tglBerangkat,
    };

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
          widget.ruteAwal + ' - ' + widget.ruteAkhir,
          style: TextStyle(
            color: Color(0xff181D2D),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              print("asd");
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                )),
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 8, bottom: 24),
                            child: Text(
                              "Filter Kapal",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        _buildRadioButton(),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.filter_alt_rounded,
              color: Color(0xff333E63),
            ),
          ),
        ],
      ),
      body: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(35)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalSpacing(),
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 5),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  //Tab
                  DateTabInActive(
                    date: angka1,
                    day: huruf1,
                  ),
                  DateTabInActive(
                    date: angka2,
                    day: huruf2,
                  ),
                  DateTabActive(
                    date: angka3,
                    day: huruf3,
                  ),
                  DateTabInActive(
                    date: angka4,
                    day: huruf4,
                  ),
                  DateTabInActive(
                    date: angka5,
                    day: huruf5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: FutureBuilder(
                future: ApiService().getJadwal(data, "/kapalWhereRute"),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Jadwal>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Something wrong with message: ${snapshot.error.toString()}"),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<Jadwal> jadwal = snapshot.data;
                    if (jadwal.isEmpty) {
                      return DataKosong(
                        text: "Tidak Ada Kapal yang Tersedia Saat Ini",
                      );
                    }

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Jadwal data = jadwal[index];

                        bool penum = false;
                        bool kap = false;
                        String sisa = "";

                        switch (data.jenis_kapal) {
                          case "Penumpang":
                            penum = true;
                            sisa = data.sisa_tiket_penumpang.toString();
                            break;
                          case "Kendaraan":
                            kap = true;
                            sisa = data.sisa_tiket_kendaraan.toString();
                            break;
                          case "Penumpang & Kendaraan":
                            penum = true;
                            kap = true;
                            sisa = data.sisa_tiket_penumpang.toString();
                            break;
                          default:
                        }

                        bool display = true;

                        if (_indexSort == 0) {
                        } else if (_indexSort == 1) {
                          if (data.nama_kapal != "PELNI") {
                            display = false;
                          }
                        } else if (_indexSort == 2) {
                          if (data.nama_kapal != "Dharma Lautan Utama (DLU)") {
                            display = false;
                          }
                        } else if (_indexSort == 3) {
                          if (data.nama_kapal !=
                              "Damai Lautan Nusantara (DLN)") {
                            display = false;
                          }
                        }


                        DateTime tgl_awal = new DateFormat("yyyy-MM-dd")
                            .parse(data.tgl_berangkat);
                        DateTime tgl_akhir =
                            new DateFormat("yyyy-MM-dd").parse(data.tgl_tiba);
                        DateTime jam_awal =
                            new DateFormat("HH:mm").parse(data.jam_berangkat);
                        DateTime jam_akhir =
                            new DateFormat("HH:mm").parse(data.jam_tiba);
                        DateFormat tglFormat = DateFormat('dd MMM yy', 'id');
                        DateFormat jamFormat = DateFormat('HH:mm', 'id');

                        var t1 = tglFormat.format(tgl_awal).toString();
                        var t2 = tglFormat.format(tgl_akhir).toString();
                        var j1 = jamFormat.format(jam_awal).toString();
                        var j2 = jamFormat.format(jam_akhir).toString();

                        var tgl = t1 +
                            ", " +
                            j1 +
                            " WIB - " +
                            t2 +
                            ", " +
                            j2 +
                            " WIB";

                        return display
                            ? Container(
                                margin: EdgeInsets.only(bottom: 32),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Kapal ' + data.nama_kapal,
                                          style: TextStyle(
                                            color: Color(0xff59597C),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Arial',
                                          ),
                                        ),
                                        Text(
                                          data.lama_perjalanan + ' \nLangsung',
                                          style: TextStyle(
                                            color: Color(0xff979797),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Arial',
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '\t\t\t(' + data.km + ')',
                                      style: TextStyle(
                                        color: Color(0xff59597C),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Arial',
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(8),
                                          right:
                                              getProportionateScreenWidth(21)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Text(
                                              tgl,
                                              style: TextStyle(
                                                color: Color(0xff707070),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Arial',
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Text(
                                              'Tersedia sisa ' + sisa,
                                              style: TextStyle(
                                                color: Color(0xff979797),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Arial',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      endIndent:
                                          getProportionateScreenWidth(17),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Wrap(
                                              runSpacing: 5,
                                              children: [
                                                penum
                                                    ? OrangeDropdown(
                                                        text: 'Kelas Kapal',
                                                        onPress: () {
                                                          showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return buildModalPenumpang(
                                                                  context,
                                                                  data.id_jadwal
                                                                      .toString(),
                                                                  data.km
                                                                      .toString());
                                                            },
                                                          );
                                                        },
                                                      )
                                                    : Container(),
                                                kap
                                                    ? OrangeDropdown(
                                                        text: 'Kendaraan',
                                                        onPress: () {
                                                          showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return buildModalKendaraan(
                                                                context,
                                                                data.id_jadwal
                                                                    .toString(),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: PesanButton(
                                              onPress: () async {
                                                SharedPreferences
                                                    sharedPreferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                if (sharedPreferences
                                                        .getString("id") ==
                                                    null) {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/login',
                                                  );
                                                } else {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/pemesanan',
                                                    arguments: PemesananScreen(
                                                      id: sharedPreferences
                                                          .getString("id"),
                                                      id_jadwal: data.id_jadwal
                                                          .toString(),
                                                      namaKapal: 'Kapal ' +
                                                          data.nama_kapal +
                                                          ' (' +
                                                          data.km +
                                                          ')',
                                                      isKendaraan: kap,
                                                      isPenumpang: penum,
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container();
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _listSort
            .map(
              (e) => Row(
                children: <Widget>[
                  Radio(
                    value: e.index,
                    groupValue: _indexSort,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      _indexSort = value;
                      _selectedSort = e.text;

                      // _listFuture = _apiService.getPengaduan(fil);
                      setState(() {
                        print(_indexSort);
                      });
                      Navigator.pop(context);
                      // });
                    },
                  ),
                  Text(e.text),
                ],
              ),
            )
            .toList());
  }
}

class RadioGroup {
  final int index;
  final String text;
  RadioGroup({this.index, this.text});
}

Widget buildModalPenumpang(context, id, nama) {
  return makeDismissible(
    context,
    child: ModalKelasPenumpang(id: id, nama: nama),
  );
}

Widget buildModalKendaraan(context, id) {
  return makeDismissible(
    context,
    child: ModalKendaraan(
      id: id,
    ),
  );
}

Widget makeDismissible(context, {Widget child}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child),
  );
}
