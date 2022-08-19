import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/models/penumpang.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class FormINputDataPenumpang extends StatefulWidget {
  bool isDewasa;
  FormINputDataPenumpang({Key key, this.isDewasa}) : super(key: key);

  @override
  _FormINputDataPenumpangState createState() => _FormINputDataPenumpangState();
}

class _FormINputDataPenumpangState extends State<FormINputDataPenumpang> {
  TextEditingController namaC = TextEditingController();
  TextEditingController noIdentitasC = TextEditingController();
  TextEditingController telpC = TextEditingController();
  TextEditingController tempatLahirC = TextEditingController();
  TextEditingController tglLahirC = TextEditingController();

  final identitasItems = ['KTP', 'KK'];
  String identitas;

  final jenisKItems = ['Laki - Laki', 'Perempuan'];
  String jenisK;

  DateTime date = DateTime.now();
  DateTime tgl;
  bool dateSelected = false;
  String getDate() {
    var dateFormated = DateFormat('d MMMM yyyy', 'id');
    if (dateSelected == false) {
      return dateFormated.format(DateTime.now());
    } else {
      return dateFormated.format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    tglLahirC.text = getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: Container(
        // height: SizeConfig.screenHeight! * 0.87,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // VerticalSpacing(),
              SizedBox(
                height: 18,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: getProportionateScreenWidth(27),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorSecondary,
                      ),
                      child: Image.asset('assets/icons/emoji-happy.png'),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Data Penumpang',
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
              Divider(
                indent: 11,
                endIndent: 11,
              ),
              VerticalSpacing(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(27),
                ),
                child: Form(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Lengkap',
                            style: TextStyle(
                              color: Color(0xff9F9FB9),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Arial',
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: namaC,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.grey[100],
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalSpacing(),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jenis Identitas',
                                  style: TextStyle(
                                    color: Color(0xff9F9FB9),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    child: widget.isDewasa
                                        ? DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: identitas,
                                              isExpanded: true,
                                              items: identitasItems
                                                  .map(buildMenuItem)
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  this.identitas =
                                                      value.toString();
                                                });
                                              },
                                              hint: Text(
                                                '- Pilih -',
                                                style: TextStyle(
                                                  color: Color(0xff59597C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Arial',
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'KK',
                                                  style: TextStyle(
                                                    color: Color(0xff59597C),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Arial',
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Icon(Icons.keyboard_arrow_down),
                                              ],
                                            ),
                                          )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nomor Identitas',
                                  style: TextStyle(
                                    color: Color(0xff9F9FB9),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  controller: noIdentitasC,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      VerticalSpacing(),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tempat Lahir',
                                  style: TextStyle(
                                    color: Color(0xff9F9FB9),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  controller: tempatLahirC,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Lahir',
                                  style: TextStyle(
                                    color: Color(0xff9F9FB9),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    pickDate(context);
                                  },
                                  child: TextFormField(
                                    enabled: false,
                                    controller: tglLahirC,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      VerticalSpacing(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jenis Kelamin',
                            style: TextStyle(
                              color: Color(0xff9F9FB9),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Arial',
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: jenisK,
                                isExpanded: true,
                                items: jenisKItems.map(buildMenuItem).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    this.jenisK = value.toString();
                                  });
                                },
                                hint: Text(
                                  '- Pilih Jenis Kelamin -',
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
                      VerticalSpacing(),
                      widget.isDewasa
                          ? Container(
                              margin: EdgeInsets.only(bottom: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nomor Telepon',
                                    style: TextStyle(
                                      color: Color(0xff9F9FB9),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    controller: telpC,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(0),
                            ),

                      // VerticalSpacing(),
                      // VerticalSpacing(),
                      TextButton(
                        onPressed: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();

                          var telp = " ";
                          if (telpC.text != null) {
                            telp = telpC.text;
                          }

                          var data = {
                            'id_user': sharedPreferences.getString("id"),
                            'nama_penumpang': namaC.text,
                            'jenis_identitas': identitas,
                            'telp': telp,
                            'no_identitas': noIdentitasC.text,
                            'ttl': tempatLahirC.text + ", " + tglLahirC.text,
                            'jk': jenisK,
                          };

                          print(data);
                          String jenis;
                          if (widget.isDewasa == false) {
                            jenis = "0";
                            identitas = "KK";
                          } else {
                            jenis = "1";
                          }

                          EasyLoading.show(
                            status: 'loading...',
                            maskType: EasyLoadingMaskType.black,
                          );
                          Penumpang penumpang = Penumpang(
                            id_user:
                                sharedPreferences.getString("id"),
                            nama_penumpang: namaC.text,
                            jenis_identitas: identitas,
                            telp: telpC.text,
                            no_identitas: noIdentitasC.text,
                            ttl: tempatLahirC.text + ", " + tglLahirC.text,
                            jenis_kelamin: jenisK,
                            jenis_penumpang: jenis,
                          );
                          ApiService()
                              .createPenumpang(penumpang)
                              .then((isSuccess) {
                            if (isSuccess) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Sukses Menambah Penumpang"),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Gagal Menambah Penumpang"),
                              ));
                            }
                            EasyLoading.dismiss();
                          });
                        },
                        child: Container(
                          width: 140,
                          height: 50,
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Tambah',
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
                      VerticalSpacing(),
                    ],
                  ),
                ),
              ),
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
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;

    setState(() {
      date = newDate;
      dateSelected = true;
      tglLahirC.text = getDate();
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
