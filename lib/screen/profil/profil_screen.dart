import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/models/user.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:pelindo_travel/widget/body_notlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  TextEditingController namaC = TextEditingController();
  TextEditingController identitasC = TextEditingController();
  TextEditingController telpC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController tempatC = TextEditingController();

  final identitasItems = ['KTP'];
  String identitas;

  final jenisKItems = ['Laki - Laki', 'Perempuan'];
  String jenisK;

  DateTime date = DateTime.now();
  bool dateSelected = false;

  String tglLahir = "";
  String Passin = "";
  String getDate() {
    var dateFormated = DateFormat('dd MMMM yyyy', 'id');
    if (dateSelected == false) {
      return tglLahir;
    } else {
      tglLahir = dateFormated.format(date);
      return dateFormated.format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  getId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    if (localStorage.getString("id") != null) {
      setState(() {
        var sessUser = localStorage.getString("user");
        var dat = jsonDecode(sessUser);
        User user = User.fromJson(dat[0]);
        namaC.text = user.username;
        identitasC.text = user.no_ktp;
        telpC.text = user.telp;
        emailC.text = user.email;
        Passin = user.pass;

        jenisK = user.jenis_kelamin;
        identitas = "KTP";
        // print(user.jenis_kelamin);

        if (user.ttl != null) {
          var str = user.ttl;
          var parts = str.split(',');
          tempatC.text = parts[0].trim();
          tglLahir = parts[1].trim();
        } else {
          var dateFormated = DateFormat('dd MMMM yyyy', 'id');

          tglLahir = dateFormated.format(DateTime.now());
        }

        // checkBayar(id);
        // id_booking = localStorage.getString("status_booking");
      });
    }
  }

  @override
  void initState() {
    getId();

    // TODO: implement initState
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
            'Profil',
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
          // height: SizeConfig.screenHeight!,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalSpacing(),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
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
                        'Data Pemesan',
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
                                  Container(
                                    width: 100,
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
                                        value: identitas,
                                        isExpanded: true,
                                        items: identitasItems
                                            .map(buildMenuItem)
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            this.identitas = value.toString();
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
                                        icon: Icon(Icons.keyboard_arrow_down),
                                      ),
                                    ),
                                  ),
                                  // TextFormField(
                                  //   decoration: InputDecoration(
                                  //     floatingLabelBehavior:
                                  //         FloatingLabelBehavior.never,
                                  //     filled: true,
                                  //     fillColor: Colors.grey[100],
                                  //     enabledBorder: UnderlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //           color: Colors.grey.withOpacity(0.5)),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Expanded(
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
                                  TextFormField(
                                    controller: identitasC,
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
                            ),
                          ],
                        ),
                        VerticalSpacing(),
                        Column(
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
                            TextFormField(
                              controller: tempatC,
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
                        Column(
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
                            InkWell(
                              onTap: () {
                                pickDate(context);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
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
                          ],
                        ),
                        VerticalSpacing(),
                        Column(
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
                                      color: Colors.grey.withOpacity(0.5)),
                                ),
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
                                  items:
                                      jenisKItems.map(buildMenuItem).toList(),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Color(0xff9F9FB9),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Arial',
                              ),
                            ),
                            TextFormField(
                              controller: emailC,
                              // keyboardType: TextInputType.emailAddress,
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
                        TextButton(
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();

                            EasyLoading.show(
                              status: 'loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            User user = User(
                              id_user:
                                  int.parse(sharedPreferences.getString("id")),
                              username: namaC.text,
                              email: emailC.text,
                              no_ktp: identitasC.text,
                              ttl: tempatC.text + ", " + tglLahir,
                              jenis_kelamin: jenisK,
                              telp: telpC.text,
                            );

                            ApiService()
                                .ubahProfil(user)
                                .then((isSuccess) async {
                              print(isSuccess);
                              if (isSuccess) {
                                var data = {
                                  'email': emailC.text,
                                  'pass': Passin,
                                };

                                var res =
                                    await ApiService().postData(data, '/login');
                                var body = json.decode(res.body);
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();
                                localStorage.setString(
                                    'user', json.encode(body['user']));

                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Sukses Mengubah Profil"),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Gagal Mengubah Profil"),
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
                                'SAVE',
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
        ));
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
