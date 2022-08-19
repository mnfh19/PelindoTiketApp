import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/models/user.dart';
import 'package:pelindo_travel/screen/beranda/beranda_screen.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  _login() async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'email': emailC.text,
      'pass': passC.text,
    };

    try {
       
      var res = await ApiService().postData(data, '/login');
      var body = json.decode(res.body);
      print(body);
      
     
      
      if (body['respon']) {
        localStorage.setString('user', json.encode(body['user']));

        var sessUser = localStorage.getString("user");
        var dat = jsonDecode(sessUser);
        User user = User.fromJson(dat[0]);

        localStorage.setString('id', user.id_user.toString());

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        // _showMsg(body['msg']);
        if (body['msg'] == "User Belum Aktif, Silahkan Aktivasi Akun Anda") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(body['msg']),
            action: SnackBarAction(
              label: 'Verif Akun',
              onPressed: () {
                Navigator.pushNamed(context, '/kode-verifikasi');
              },
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(body['msg']),
          ));
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e),
      ));
    }
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
          'LOGIN',
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
          height: SizeConfig.screenHeight * 0.87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpacing(),
              VerticalSpacing(),
              Center(
                child: Text(
                  'Silahkan login untuk melakukan pemesanan',
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 34),
              Container(
                padding: EdgeInsets.only(left: 16),
                width: getProportionateScreenWidth(300),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xffE8E8E8),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: emailC,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    suffixIcon: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Image(
                        height: 12,
                        width: 17,
                        image: AssetImage(
                          'assets/icons/mail.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 17),
              Container(
                padding: EdgeInsets.only(left: 16),
                width: getProportionateScreenWidth(300),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xffE8E8E8),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: passC,
                  obscureText: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    suffixIcon: Container(
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      child: Image(
                        height: 14,
                        width: 10,
                        image: AssetImage(
                          'assets/icons/lock.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 27),
              Container(
                padding: EdgeInsets.only(right: 23),
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lupa-password');
                  },
                  child: Text(
                    'Lupa password?',
                    style: TextStyle(
                      color: Color(0xff324A59),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () => _login(),
                child: Container(
                  height: 45,
                  width: 168,
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(25),
             
                  ),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        color: Color(0xffAAAAAA),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/daftar');
                      },
                      child: Text(
                        'DAFTAR',
                        style: TextStyle(
                          color: Color(0xff38AFF2),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
